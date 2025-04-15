@unboxed
type room =
  | Center
  | Table
  | Window
  | Door

@unboxed
type terminal = Door | Watch

type roomProps = {goTo: room => unit}
type terminalProps = {}
