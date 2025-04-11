module App = {
  @react.component
  let make = (~children: React.element) => {
    <div className="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div className="mx-auto min-w-xl max-w-5xl"> {children} </div>
    </div>
  }
}

open Web

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => rootElement->Jq.append([Content.RoomD.render()])->ignore
| None => Error.panic("No root element found!")
}
