@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.Center)
  let {path, terminal} = PathMap.get(current)

  module CurrentRoom = {
    let make = path
  }

  module CurrentTerminal = {
    let make = terminal
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentRoom goTo />
    <CurrentTerminal />
  </div>
}
