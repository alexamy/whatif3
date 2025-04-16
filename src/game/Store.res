type roomTableState = {}
type roomDoorState = {mutable count: int, mutable options: array<Path.options>}
type state = RoomDoor(roomDoorState) | RoomTable(roomTableState)

let store = Mobx.observable(
  Map.fromArray([
    (
      Path.RoomDoor,
      RoomDoor({count: 1, options: [(React.string("Вернуться"), Path.RoomCenter)]}),
    ),
    (Path.RoomTable, RoomTable({})),
  ]),
)

let get = key => {
  switch Map.get(store, key) {
  | Some(state) => state
  | None => failwith("Store key not found")
  }
}

let update = (key, updater) => {
  switch Map.get(store, key) {
  | Some(state) => updater(state)
  | None => failwith("Store key not found")
  }
}
