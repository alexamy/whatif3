@unboxed
type room =
  | RoomCenter
  | RoomTable
  | RoomWindow
  | RoomDoor

type props = {goTo: room => unit}

type options = (React.element, room)
