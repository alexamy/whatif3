let map = Core__Map.fromArray([(Path.Center, RoomCenter.make), (Path.Table, RoomTable.make)])

exception NotFound

let get = current =>
  switch Core__Map.get(map, current) {
  | Some(make) => make
  | None => raise(NotFound)
  }
