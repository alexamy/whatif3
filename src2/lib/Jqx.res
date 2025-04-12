type element = Jq.t
type component<'props> = Jsx.component<'props>
type componentLike<'props, 'return> = Jsx.componentLike<'props, 'return>

@module("preact")
external jsx: (component<'props>, 'props) => element = "jsx"

@module("preact")
external jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsx"

@module("preact")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("preact")
external jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsxs"

external array: array<element> => element = "%identity"
let null = Jq.Dom.null
let float: float => element = number => number->Float.toString->Jq.string
let int: int => element = number => number->Int.toString->Jq.string
let string: string => element = Jq.string

type fragmentProps = {children?: element}
@module("preact") external jsxFragment: component<fragmentProps> = "Fragment"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  type p = {class?: string, children?: element}

  let jsx = (string, props) => {
    let element = Jq.makeFromString(string)
    props.class->Option.map(class => Jq.addClass(element, class))->ignore
    props.children->Option.map(child => Jq.append(element, [child]))->ignore
    element
  }

  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }

  let jsxs = jsx
  let jsxsKeyed = jsxKeyed

  external someElement: element => option<element> = "%identity"
}
