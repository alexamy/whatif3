exception NotFound(Path.room)

type info = {
  left: Path.props => React.element,
  right: Path.props => React.element,
}

let map: Map.t<Path.room, info> = Map.fromArray([
  (Path.Center, {left: RoomCenter.make, right: Terminal.make}),
  (Path.Table, {left: RoomTable.make, right: Terminal.make}),
])

let get = current =>
  switch Map.get(map, current) {
  | Some(info) => info
  | None => raise(NotFound(current))
  }
