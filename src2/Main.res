module App = {
  let mount = (root: Web.Node.t, children: Jqx.element) => {
    let root = Jq.fromNode(root)
    Jq.append(root, Jqx.toArray(children))
  }

  let render = (child: Jqx.element) => {
    <div class="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div class="mx-auto min-w-xl max-w-5xl"> {child} </div>
    </div>
  }
}

switch Web.Document.document->Web.Document.querySelector("#root") {
| Some(rootElement) => App.mount(rootElement, App.render(<Game />))
| None => Error.panic("No root element found!")
}
