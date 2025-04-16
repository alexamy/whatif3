@unboxed
type room =
  | RoomCenter
  | RoomTable
  | RoomWindow
  | RoomDoor

type pathProps = {goTo: room => unit}
