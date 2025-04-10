module App = {
  @react.component
  let make = (~children: React.element) => {
    <div className="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div className="mx-auto min-w-xl max-w-5xl"> {children} </div>
    </div>
  }
}

open Web

let render = rootElement => {
  let element = Jq.create(#div, "bg-red-500 text-blue-600")
  ->Jq.text("Hello")
  ->Jq.appendTo(rootElement)
}

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => render(rootElement)
| None => Error.panic("No root element found!")
}
