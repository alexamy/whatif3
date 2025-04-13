type leaf = Jq.t
type element = One(leaf) | Many(array<leaf>)
type componentLike<'props, 'return> = 'props => 'return
type component<'props> = componentLike<'props, element>

let fromElement: element => array<Jq.t> = element => {
  switch element {
  | One(element) => [element]
  | Many(elements) => elements
  }
}

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

@module("preact")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("preact")
external jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsxs"

let array: array<element> => element = elements => {
  Many(
    Array.flatMap(elements, element =>
      switch element {
      | One(element) => [element]
      | Many(elements) => elements
      }
    ),
  )
}

let string: string => element = text => text->Jq.string->One
let int: int => element = number => number->Int.toString->string
let float: float => element = number => number->Float.toString->string

type fragmentProps = {children?: element}
@module("preact") external jsxFragment: component<fragmentProps> = "Fragment"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  type p = {ref?: ref<Jq.t>, class?: string, children?: element}

  let jsx = (string, props) => {
    let element = Jq.makeFromString(string)
    props.ref->Option.map(ref => ref := element)->ignore
    props.class->Option.map(class => Jq.addClass(element, class))->ignore
    props.children->Option.map(child => Jq.append(element, fromElement(child)))->ignore
    One(element)
  }

  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }

  let jsxs = jsx
  let jsxsKeyed = jsxKeyed

  external someElement: element => option<element> = "%identity"
}
