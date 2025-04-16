@unboxed
type room =
  | RoomCenter
  | RoomTable
  | RoomWindow
  | RoomDoor

type pathProps = {goTo: room => unit}

type pathOptions = {
  element: React.element,
  room: room,
  hidden?: bool,
}
