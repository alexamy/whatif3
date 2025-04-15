type state = {mutable current: int}

let state = Mobx.observable({
  current: 1,
})

let increase = () => state.current = state.current + 1

// TODO: check auto wrap
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
    {React.string(Int.toString(state.current))}
    <button onClick={_ => increase()}> {React.string("+")} </button>
  </div>
}
