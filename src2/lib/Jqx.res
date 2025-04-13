type element = Jq.t
type componentLike<'props, 'return> = 'props => 'return
type component<'props> = componentLike<'props, element>

@module("preact")
external jsx: (component<'props>, 'props) => element = "jsx"

@module("preact")
external jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsx"

@module("preact")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("preact")
external jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsxs"

external array: array<element> => element = "%identity"
let toArray: element => array<element> = %raw(`function(element) {
  return Array.isArray(element) ? element : [element]
}`)

let string: string => element = text => text->Jq.string
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
    props.children->Option.map(child => Jq.append(element, toArray(child)))->ignore
    element
  }

  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }

  let jsxs = jsx
  let jsxsKeyed = jsxKeyed

  external someElement: element => option<element> = "%identity"
}
