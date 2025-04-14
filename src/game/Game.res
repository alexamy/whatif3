@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.Center)

  Utils.useLog((current :> string))

  module CurrentRoom = {
    let make = RoomCenter.make
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentRoom goTo />
    <Terminal color=Blue header="Умные часы 3000" />
  </div>
}
