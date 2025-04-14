type place =
  | Center
  | Table
  | Window
  | Door

type computer = Door | Watch

type destination = (React.element, place)

type screen = {
  place: place,
  computer: computer,
  options: array<destination>,
}
