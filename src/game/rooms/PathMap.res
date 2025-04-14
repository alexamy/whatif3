exception NotFound(Path.room)

let map = Core__Map.fromArray([
  (Path.Center, (RoomCenter.make, Terminal.make)),
  (Path.Table, (RoomTable.make, Terminal.make)),
])

let get = current =>
  switch Core__Map.get(map, current) {
  | Some(make) => make
  | None => raise(NotFound(current))
  }
