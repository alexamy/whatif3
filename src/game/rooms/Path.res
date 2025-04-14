type place =
  | Center
  | Table
  | Window
  | Door

type computer = Door | Watch

type screen = {
  place: place,
  computer: computer,
  options: array<(React.element, place)>,
}
