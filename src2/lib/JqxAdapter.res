type element = Jqx.element
type component<'props> = Jqx.component<'props>
type componentLike<'props, 'return> = Jqx.componentLike<'props, 'return>

let jsx: (component<'props>, 'props) => element = (component, props) => {
  component(props)
}

@@warning("-27")
let jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = (
  component,
  props,
  ~key=?,
  @ignore unit,
) => {
  jsx(component, props)
}
@@warning("+27")

let jsxs: (component<'props>, 'props) => element = jsx
let jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = jsxKeyed

let array: array<element> => element = Jqx.array
let string: string => element = Jqx.string
let int: int => element = Jqx.int
let float: float => element = Jqx.float

type fragmentProps = {children?: element}
let jsxFragment: component<fragmentProps> = (props: fragmentProps) => {
  Option.getWithDefault(props.children, Jqx.null())
}

module Elements = {
  let jsx = (string, props) => Jqx.make(string, props)

  @@warning("-27")
  let jsxKeyed = (string, props, ~key=?, @ignore unit) => {
    jsx(string, props)
  }
  @@warning("+27")

  let jsxs = jsx
  let jsxsKeyed = jsxKeyed

  let someElement: element => option<element> = element => Some(element)
}
