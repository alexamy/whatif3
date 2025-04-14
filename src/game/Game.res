let map = Core__Map.fromArray([(Path.Center, RoomCenter.make), (Path.Table, RoomTable.make)])

exception NotFound

@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.Center)

  module CurrentRoom = {
    let make = switch Core__Map.get(map, current) {
    | Some(make) => make
    | None => raise(NotFound)
    }
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentRoom goTo />
    <Terminal color=Blue header="Умные часы 3000" />
  </div>
}
