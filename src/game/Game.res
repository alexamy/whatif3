@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.Center)

  module CurrentRoom = {
    let make = PathMap.get(current)
    React.setDisplayName(make, "CurrentRoom")
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentRoom goTo />
    <Terminal color=Blue header="Умные часы 3000" />
  </div>
}
