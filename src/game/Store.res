type roomTableState = {mutable note1: HookSwitch.state}
type roomDoorState = {mutable count: int, mutable options: array<Path.options>}
type state = RoomDoor(roomDoorState) | RoomTable(roomTableState)

let initial = Map.fromArray([
  (
    Path.RoomDoor,
    RoomDoor({count: 1, options: [(React.string("Вернуться"), Path.RoomCenter)]}),
  ),
  (
    Path.RoomTable,
    RoomTable({
      note1: HookSwitch.Unvisited,
    }),
  ),
])

let store = Mobx.observable(initial)

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
