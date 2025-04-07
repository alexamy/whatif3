/**Returns a boolean that toggles every ms milliseconds */
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

module Terminal = {
  @react.component
  let make = () => {
    let tick = useTick(400)

    let (message, setMessage) = React.useState(_ => "333")
    let output = `> ${message}${tick ? "█" : ""}`

    <div className="font-mono bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex items-end">
      {React.string(output)}
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
