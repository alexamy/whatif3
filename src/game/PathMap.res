exception NotFound(Path.room)

type info = {
  left: Path.pathProps => React.element,
  right: Path.pathProps => React.element,
}

let map: Map.t<Path.room, info> = Map.fromArray([
  (Path.RoomCenter, {left: RoomCenter.make, right: TerminalHandwatch.make}),
  (Path.RoomTable, {left: RoomTable.make, right: TerminalHandwatch.make}),
  (Path.RoomDoor, {left: RoomDoor.make, right: RoomDoorTerminal.make}),
])

let get = current =>
  switch Map.get(map, current) {
  | Some(info) => info
  | None => raise(NotFound(current))
  }
