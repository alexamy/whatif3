let mount = (root: Web.Node.t, children: Jqx.element) => {
  Jq.append(root, Jqx.toArray(children))
}

switch Web.Document.document->Web.Document.querySelector("#root") {
| Some(rootElement) => mount(rootElement, <Game />)
| None => Error.panic("No root element found!")
}
