@unboxed
type room =
  | Center
  | Table
  | Window
  | Door

@unboxed
type computer = Door | Watch

type destination = (React.element, room)

type screen = {
  room: room,
  computer: computer,
  options: array<destination>,
}

type props = {goTo: room => unit}
