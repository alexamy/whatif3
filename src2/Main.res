open Web

let mount = (root: Node.t, children: Jqx.element) => {
  Jq.append(root, Jqx.toJqArray(children))
}

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => mount(rootElement, <Game />)
| None => Error.panic("No root element found!")
}
