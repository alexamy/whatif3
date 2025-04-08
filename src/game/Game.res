let useLog = msg => {
  React.useEffect(() => {
    Console.log(msg)
    None
  }, [msg])
}

module Terminal = {
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

  // Returns a terminal display with text lines displayed
  module Display = {
    type options = {width: int, height: int} // 36x14
    type t = {display: array<string>, echo: string => unit, clear: unit => unit}

    let useDisplay = options => {
      let (lines, setLines) = React.useState(_ => [])

      let display = React.useMemo(() => {
        let start = Array.length(lines) - options.height
        let offset = start > 0 ? start : 0

        Array.slice(lines, ~offset, ~len=options.height)
      }, (lines, options.height))

      let echo = newLine => setLines(lines => [...lines, newLine])
      let clear = () => setLines(_ => [])

      {display, echo, clear}
    }
  }

  module Input = {
    type options = {width: int}
    type t = {
      message: string,
      input: string,
      focus: bool => unit,
      removeChar: unit => unit,
      addChar: string => unit,
    }

    let getAllButLast = str => String.slice(str, ~start=0, ~end=String.length(str) - 1)

    let useInput = options => {
      let tick = useTick(400)
      let (focused, setFocused) = React.useState(_ => false)

      let (message, setMessage) = React.useState(_ => "")
      let beam = tick && focused ? "█" : ""
      let input = `> ${message}${beam}`

      let focus = state => setFocused(_ => state)
      let removeChar = () => setMessage(prev => getAllButLast(prev))
      let addChar = char => {
        let isAllWidth = String.length(message) === options.width
        setMessage(prev => isAllWidth ? prev : prev ++ char)
      }

      {message, input, focus, removeChar, addChar}
    }
  }

  @react.component
  let make = () => {
    let {display, echo, clear} = Display.useDisplay({width: 36, height: 14})
    let {message, input, focus, removeChar, addChar} = Input.useInput({
      width: 36,
    })

    let processMessage = text => {
      switch String.trim(text) {
      | "clear" => clear()
      | message if String.length(message) > 0 => echo(message)
      | _ => ()
      }
    }

    let onKeyDown = e => {
      switch JsxEvent.Keyboard.key(e) {
      | "Enter" => processMessage(message)
      | "Backspace" => removeChar()
      | key if String.length(key) === 1 => addChar(key)
      | _ => ()
      }
    }

    let lines = React.array(
      Array.mapWithIndex(display, (i, line) =>
        <div key={Int.toString(i)}> {React.string(line)} </div>
      ),
    )

    <div
      className="outline-0 whitespace-pre text-nowrap font-mono bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex flex-col justify-end"
      tabIndex=0
      onKeyDown
      onClick={_ => focus(true)}
      onFocus={_ => focus(true)}
      onBlur={_ => focus(false)}>
      <div className="overflow-y-auto"> {lines} </div>
      <div> {React.string(input)} </div>
    </div>
  }
}

@react.component
let make = () => {
  let (shown, setShown) = React.useState(_ => false)

  <div className="flex">
    <Screen
      content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
      options={[(React.string("Go back"), _ => setShown(prev => !prev))]}
    />
    <Terminal />
  </div>
}
