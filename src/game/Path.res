@unboxed
type room =
  | RoomCenter
  | RoomTable
  | RoomWindow
  | RoomDoor

type props = {goTo: room => unit}

type options = {
  element: React.element,
  room: room,
  hidden?: bool,
}
