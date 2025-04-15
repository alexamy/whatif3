@unboxed
type room =
  | RoomCenter
  | RoomTable
  | RoomWindow
  | RoomDoor

type roomProps = {goTo: room => unit}
type terminalProps = {}
