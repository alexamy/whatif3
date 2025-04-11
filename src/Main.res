module App = {
  let render = (children: Jq.t) => {
    let container = Jq.make(#div)
    Jq.addClass(container, "w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100")

    let center = Jq.make(#div)
    Jq.addClass(center, "mx-auto min-w-xl max-w-5xl")

    Jq.append(container, [center])
    Jq.append(center, [children])

    container
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
