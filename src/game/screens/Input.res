type options = {width: int}
type command =
  | Clear
  | RemoveChar
  | AddChar(string)

type t = {
  message: string,
  beam: string,
  input: command => unit,
  focus: bool => unit,
}

// Returns a boolean that toggles every ms milliseconds
let useTick = ms => {
  let (tick, setTick) = React.useState(_ => true)

  React.useEffect(() => {
    let intervalId = Js.Global.setInterval(() => {
      setTick(prev => !prev)
    }, ms)

    Some(_ => Js.Global.clearInterval(intervalId))
  }, (ms, setTick))

  tick
}

let useInput = options => {
  let tick = useTick(400)
  let (focused, setFocused) = React.useState(_ => false)

  let (message, setMessage) = React.useState(_ => "")
  let beam = tick && focused ? "█" : ""

  let focus = state => setFocused(_ => state)
  let input = command => {
    switch command {
    | Clear => setMessage(_ => "")
    | RemoveChar => {
        let allButLast = String.slice(message, ~start=0, ~end=String.length(message) - 1)
        setMessage(_ => allButLast)
      }
    | AddChar(char) => {
        let isAllWidth = String.length(message) === options.width
        setMessage(prev => isAllWidth ? prev : prev ++ char)
      }
    }
  }

  {message, beam, input, focus}
}
