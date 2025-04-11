module App = {
  let render = (children: Jq.t) => {
    Jq.make(#div)
    ->Jq.addClass("w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100")
    ->Jq.append([
      Jq.make(#div)
      ->Jq.addClass("mx-auto min-w-xl max-w-5xl")
      ->Jq.append([children]),
    ])
  }
}

open Web

let mount = (root: Node.t, children: Jq.t) => {
  root->Jq.fromElement->Jq.append([children])->ignore
}

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => mount(rootElement, App.render(Content.RoomD.render()))
| None => Error.panic("No root element found!")
}
