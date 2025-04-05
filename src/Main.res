module App = {
  @react.component
  let make = (~children: React.element) => {
    <div className="w-full h-full min-h-screen m-0 p-2 bg-gray-900 text-gray-100"> {children} </div>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(rootElement) => {
    let root = ReactDOM.Client.createRoot(rootElement)
    ReactDOM.Client.Root.render(
      root,
      <App>
        <Game />
      </App>,
    )
  }
| None => Error.panic("No root element found!")
}
