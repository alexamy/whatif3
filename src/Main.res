module App = {
  @react.component
  let make = (~children: React.element) => {
    <div className="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
      <div className="mx-auto min-w-xl max-w-5xl"> {children} </div>
    </div>
  }
}

let render = rootElement => {
  let element = Web.document->Web.createElement(#div)
  element->Web.classList->Web.addClass(["bg-red-500"])
  element->Web.textContent("Hello2")

  rootElement->Web.appendChild(element)
}

switch Web.document->Web.querySelector("#root") {
| Some(rootElement) => render(rootElement)
| None => Error.panic("No root element found!")
}
