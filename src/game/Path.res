@unboxed
type room =
  | Center
  | Table
  | Window
  | Door

@unboxed
type computer = Door | Watch

type props = {goTo: room => unit}
