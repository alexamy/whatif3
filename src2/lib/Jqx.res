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

/* These are needed for Fragment (<> </>) support */
type fragmentProps = {children?: element}

@module("preact") external jsxFragment: component<fragmentProps> = "Fragment"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  type p = {class?: string}
  type jsxProps = {...p, children?: element}
  type jsxsProps = {...p, children?: array<element>}

  let make = (string, props: p, ~children=?) => {
    let element = Jq.makeFromString(string)
    props.class->Option.map(class => Jq.addClass(element, class))->ignore
    children->Option.map(children => Jq.append(element, children))->ignore
    element
  }

  let jsx = (string, props: jsxProps) => {
    let children = Option.mapWithDefault(props.children, [], child => [child])
    make(string, (props :> p), ~children)
  }

  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }

  let jsxs = (string, props: jsxsProps) => {
    make(string, (props :> p), ~children=?props.children)
  }

  let jsxsKeyed = (string, props, ~key=?, @ignore unit) => {
    jsxs(string, props)
  }

  external someElement: element => option<element> = "%identity"
}
