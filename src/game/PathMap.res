exception NotFound(Path.room)

type info = {
  left: Path.roomProps => React.element,
  right: Path.terminalProps => React.element,
}

let map: Map.t<Path.room, info> = Map.fromArray([
  (Path.RoomCenter, {left: RoomCenter.make, right: Terminal.Handwatch.make}),
  (Path.RoomTable, {left: RoomTable.make, right: Terminal.Handwatch.make}),
  (Path.RoomDoor, {left: RoomDoor.make, right: Terminal.RoomDoorTerminal.make}),
])

let get = current =>
  switch Map.get(map, current) {
  | Some(info) => info
  | None => raise(NotFound(current))
  }
