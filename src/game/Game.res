let useLog = msg => {
  React.useEffect(() => {
    Console.log(msg)
    None
  }, [])
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
    }, [])

    tick
  }

  // Returns a terminal display with text lines displayed
  module Display = {
    type options = {width: int, height: int} // 36x14
    type t = {display: array<string>, addLine: string => unit}

    let use = options => {
      let (lines, setLines) = React.useState(_ => [])

      let display = React.useMemo(() => {
        let start = Array.length(lines) - options.height
        let offset = start > 0 ? start : 0

        Array.slice(lines, ~offset, ~len=options.height)
      }, [lines])

      let addLine = newLine => setLines(lines => [...lines, newLine])

      {display, addLine}
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

    let use = options => {
      let tick = useTick(400)
      let (focused, setFocused) = React.useState(_ => false)

      let (message, setMessage) = React.useState(_ => "")
      let input = `> ${message}${tick && focused ? "█" : ""}`

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
    let {display, addLine} = Display.use({width: 36, height: 14})
    let {message, input, focus, removeChar, addChar} = Input.use({
      width: 36,
    })

    let onKeyDown = e => {
      switch JsxEvent.Keyboard.key(e) {
      | "Enter" => String.length(message) > 0 ? addLine(message) : ()
      | "Backspace" => removeChar()
      | key if String.length(key) === 1 => addChar(key)
      | _ => ()
      }
    }

    <div
      className="outline-0 whitespace-pre text-nowrap font-mono bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex flex-col justify-end "
      tabIndex=0
      onKeyDown
      onClick={_ => focus(true)}
      onFocus={_ => focus(true)}
      onBlur={_ => focus(false)}>
      {React.array(
        display->Array.mapWithIndex((i, line) =>
          <div key={Int.toString(i)}> {React.string(line)} </div>
        ),
      )}
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
