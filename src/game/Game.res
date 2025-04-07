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

  // 36x14
  type size = {width: int, height: int}

  let useTerminal = size => {
    size.width->ignore
  }

  let getAllButLast = str => String.slice(str, ~start=0, ~end=String.length(str) - 1)

  @react.component
  let make = () => {
    let tick = useTick(400)

    let (focused, setFocused) = React.useState(_ => false)

    let (message, setMessage) = React.useState(_ => "")
    let input = `> ${message}${tick && focused ? "█" : ""}`

    let onKeyDown = e => {
      let key = JsxEvent.Keyboard.key(e)

      if key === "Backspace" {
        setMessage(prev => getAllButLast(prev))
      } else if String.length(key) === 1 {
        setMessage(prev => prev ++ key)
      }
    }

    <div
      className="outline-0 whitespace-pre text-nowrap font-mono bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex flex-col justify-end "
      tabIndex=0
      onKeyDown
      onClick={_ => setFocused(_ => true)}
      onFocus={_ => setFocused(_ => true)}
      onBlur={_ => setFocused(_ => false)}>
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
