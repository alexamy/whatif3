type options = {width: int, height: int} // 36x14
type direction = Up | Down | Reset
type command =
  | Clear
  | Echo(array<string>)

type t = {
  lines: array<string>,
  screen: command => unit,
  viewport: direction => unit,
}

let useDisplay = options => {
  let (output, setOutput) = React.useState((_): array<string> => [])
  let (verticalOffset, setVerticalOffset) = React.useState(_ => 1)

  let lines = React.useMemo(() => {
    let start = Array.length(output) - options.height - verticalOffset
    let start = start > 0 ? start : 0

    Array.slice(output, ~start, ~end=start + options.height)
  }, (output, options.height, verticalOffset))

  let viewport = direction => {
    switch direction {
    | Reset => setVerticalOffset(_ => 0)
    | Down => setVerticalOffset(prev => Math.Int.max(prev - 1, 0))
    | Up => {
        let start = Array.length(output) - options.height
        let limit = Js.Math.max_int(0, start)
        setVerticalOffset(prev => Math.Int.min(prev + 1, limit))
      }
    }
  }

  let screen = command => {
    switch command {
    | Clear => setOutput(_ => [])
    | Echo(newLines) => setOutput(lines => Array.concat(lines, newLines))
    }
  }

  {lines, screen, viewport}
}
