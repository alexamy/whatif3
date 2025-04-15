@unboxed
type room =
  | Center
  | Table
  | Window
  | Door

type roomProps = {goTo: room => unit}
type terminalProps = {}
