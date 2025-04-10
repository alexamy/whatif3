module App = {
  @react.component
  let make = (~children: React.element) => {
    <div className="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div className="mx-auto min-w-xl max-w-5xl"> {children} </div>
    </div>
  }
}

let render = domElement => {
  let element = Cash.createElement(#div)->Cash.addClass("bg-red-500")->Cash.text("Hello")

  let root = Cash.wrapElement(domElement)
  root->Cash.append(element)
}

switch Document.document->Document.querySelector("#root") {
| Some(rootElement) => render(rootElement)->ignore
| None => Error.panic("No root element found!")
}
