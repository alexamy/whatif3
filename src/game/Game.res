@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.Center)
  let (room, computer) = PathMap.get(current)

  module CurrentRoom = {
    let make = room
    React.setDisplayName(make, "CurrentRoom")
  }

  module CurrentComputer = {
    let make = computer
    React.setDisplayName(make, "CurrentTerminal")
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentRoom goTo />
    <CurrentComputer color=Blue header="Умные часы 3000" />
  </div>
}
