type element = Jq.t
type componentLike<'props, 'return> = 'props => 'return
type component<'props> = componentLike<'props, element>

let toArray: element => array<Jq.t> = %raw(`function(element) {
  return Array.isArray(element) ? element : [element];
}`)

let jsx: (component<'props>, 'props) => element = (component, props) => {
  component(props)
}

let jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = (
  component,
  props,
  ~key=?,
  @ignore unit,
) => {
  jsx(component, props)
}

let jsxs: (component<'props>, 'props) => element = jsx
let jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = jsxKeyed

external array: array<element> => element = "%identity"
let string: string => element = text => text->Jq.string
let int: int => element = number => number->Int.toString->string
let float: float => element = number => number->Float.toString->string

type fragmentProps = {children?: element}

let jsxFragment: component<fragmentProps> = (props: fragmentProps) => {
  Option.getWithDefault(props.children, Jq.Dom.null())
}

module Make = {
  type t = {
    bind?: ref<Jq.t>,
    class?: string,
    classes?: dict<bool>,
    dependencies?: array<unit => unit>,
    attributes?: array<(string, string)>,
    children?: element,
  }

  let make = (tag, props) => {
    let element = Jq.makeFromString(tag)
    let children = props.children->Option.mapWithDefault([], toArray)
    Jq.append(element, children)

    props.bind->Option.map(ref => ref := element)->ignore
    props.class->Option.map(class => Jq.addClass(element, class))->ignore
    props.classes->Option.map(classes => Jq.toggleClasses(element, classes))->ignore

    props.dependencies
    ->Option.map(dependencies => Array.forEach(dependencies, dependency => dependency()))
    ->ignore

    props.attributes
    ->Option.map(attributes =>
      Array.forEach(attributes, ((name, value)) => Jq.setAttribute(element, name, value))
    )
    ->ignore

    element
  }
}

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  let jsx = (string, props) => {
    let element = Make.make(string, props)
    element
  }

  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }

  let jsxs = jsx
  let jsxsKeyed = jsxKeyed

  external someElement: element => option<element> = "%identity"
}
