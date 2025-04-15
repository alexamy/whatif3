@unboxed
type room =
  | Center
  | Table
  | Window
  | Door

@unboxed
type terminal = Door | Watch

type props = {goTo: room => unit}
