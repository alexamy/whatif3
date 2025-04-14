type room =
  | Center
  | Table
  | Window
  | Door

type computer = Door | Watch

type destination = (React.element, room)

type screen = {
  room: room,
  computer: computer,
  options: array<destination>,
}
