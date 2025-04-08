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
    type direction = Up | Down | Reset
    type command =
      | Clear
      | Echo(string)

    type t = {
      display: array<string>,
      screen: command => unit,
      viewport: direction => unit,
    }

    let useDisplay = options => {
      let (lines, setLines) = React.useState(_ => [])
      let (verticalOffset, setVerticalOffset) = React.useState(_ => 0)

      let display = React.useMemo(() => {
        let start = Array.length(lines) - options.height - verticalOffset
        let offset = start > 0 ? start : 0

        Array.slice(lines, ~offset, ~len=options.height)
      }, (lines, options.height, verticalOffset))

      let viewport = direction => {
        switch direction {
        | Reset => setVerticalOffset(_ => 0)
        | Down => setVerticalOffset(prev => Math.Int.max(prev - 1, 0))
        | Up => {
            let start = Array.length(lines) - options.height
            let limit = Js.Math.max_int(0, start)
            setVerticalOffset(prev => Math.Int.min(prev + 1, limit))
          }
        }
      }

      let screen = command => {
        switch command {
        | Clear => setLines(_ => [])
        | Echo(line) => setLines(lines => [...lines, line])
        }
      }

      {display, screen, viewport}
    }
  }

  module Input = {
    type options = {width: int}
    type command =
      | Focus(bool)
      | Clear
      | RemoveChar
      | AddChar(string)

    type t = {
      message: string,
      beam: string,
      run: command => unit,
    }

    let useInput = options => {
      let tick = useTick(400)
      let (focused, setFocused) = React.useState(_ => false)

      let (message, setMessage) = React.useState(_ => "")
      let beam = tick && focused ? "█" : ""

      let run = command => {
        switch command {
        | Focus(state) => setFocused(_ => state)
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

      {message, beam, run}
    }
  }

  @react.component
  let make = () => {
    let {display, screen, viewport} = Display.useDisplay({width: 36, height: 14})
    let {message, beam, run} = Input.useInput({
      width: 36,
    })

    let processMessage = text => {
      switch String.trim(text) {
      | "clear" => screen(Clear)
      | message if String.length(message) > 0 => screen(Echo(message))
      | _ => ()
      }
    }

    let onKeyDown = e => {
      switch JsxEvent.Keyboard.key(e) {
      | "Enter" => {
          processMessage(message)
          viewport(Reset)
          run(Clear)
        }
      | "Backspace" => run(RemoveChar)
      | "ArrowUp" => viewport(Up)
      | "ArrowDown" => viewport(Down)
      | key if String.length(key) === 1 => {
          run(AddChar(key))
          let msg = `${message}${key}`
        }
      | _ => ()
      }
    }

    let lines = React.array(
      Array.mapWithIndex(display, (i, line) =>
        <div key={Int.toString(i)}> {React.string(line)} </div>
      ),
    )

    <div
      className="monospace outline-0 whitespace-pre text-nowrap bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex flex-col justify-end"
      tabIndex=0
      onKeyDown
      onClick={_ => run(Focus(true))}
      onFocus={_ => run(Focus(true))}
      onBlur={_ => run(Focus(false))}>
      {lines}
      <div> {React.string("> " ++ message ++ beam)} </div>
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
