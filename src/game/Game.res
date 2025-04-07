@react.component
let make = () => {
  let (shown, setShown) = React.useState(_ => false)
  let (input, setInput) = React.useState(_ => ">")

  React.useEffect(() => {
    let intervalId = Js.Global.setInterval(() => {
      setInput(input => String.length(input) === 1 ? ">|" : ">")
    }, 400)

    Some(_ => Js.Global.clearInterval(intervalId))
  }, [])

  <div className="flex">
    <Screen
      content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
      options={[(React.string("Go back"), _ => setShown(prev => !prev))]}
    />
    <div className="font-mono bg-blue-400 text-gray-800 w-96 h-96 p-2 mx-2 flex items-end">
      {React.string(input)}
    </div>
  </div>
}
