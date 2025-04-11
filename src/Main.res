module App = {
  let render = (children: Jq.t) => {
    Jq.tree(
      #div,
      "w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100",
      [Jq.tree(#div, "mx-auto min-w-xl max-w-5xl", [children])],
    )
  }
}

open Web

let mount = (root: Node.t, children: Jq.t) => {
  let root = Jq.fromNode(root)
  Jq.append(root, [children])
}

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => mount(rootElement, App.render(Content.RoomD.render()))
| None => Error.panic("No root element found!")
}
