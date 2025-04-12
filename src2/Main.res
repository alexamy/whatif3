module App = {
  let mount = (root: Web.Node.t, children: Jq.t) => {
    let root = Jq.fromNode(root)
    Jq.append(root, [children])
  }

  let render = (child: Jq.t) => {
    let ref = ref(Jq.Dom.placeholder)
    <div ref class="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div class="mx-auto min-w-xl max-w-5xl"> {One(child)} </div>
    </div>->ignore

    ref.contents
  }
}

switch Web.Document.document->Web.Document.querySelector("#root") {
| Some(rootElement) => App.mount(rootElement, App.render(Game.render()))
| None => Error.panic("No root element found!")
}
