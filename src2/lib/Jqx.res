type element = One(Jq.t) | Many(array<Jq.t>)
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
let null = Jq.Dom.null
let float: float => element = number => One(number->Float.toString->Jq.string)
let int: int => element = number => One(number->Int.toString->Jq.string)
let string: string => element = text => One(Jq.string(text))

type fragmentProps = {children?: element}
@module("preact") external jsxFragment: component<fragmentProps> = "Fragment"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  type p = {ref?: ref<Jq.t>, class?: string, children?: element}

  let fromElement: element => array<Jq.t> = element => {
    switch element {
    | One(element) => [element]
    | Many(elements) => elements
    }
  }

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
