module Terminal = {
  @react.component
  let make = () => {
    let {display, screen, viewport} = Display.useDisplay({width: 36, height: 14})
    let {message, beam, run} = Input.useInput({
      width: 36,
    })

    // bg-emerald-700 text-white
    let (messageClass, _) = React.useState(_ => "")

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
      | key if String.length(key) === 1 => run(AddChar(key))
      | _ => ()
      }
    }

    let lines = React.array(
      Array.mapWithIndex(display, (i, line) =>
        <div key={Int.toString(i)}> {React.string(line)} </div>
      ),
    )

    <div
      className="monospace screen-w screen-h outline-0 whitespace-pre text-nowrap bg-blue-400 text-gray-800 p-2 flex flex-col justify-end"
      tabIndex=0
      onKeyDown
      onClick={_ => run(Focus(true))}
      onFocus={_ => run(Focus(true))}
      onBlur={_ => run(Focus(false))}>
      {lines}
      <div>
        {React.string("> ")}
        <span className={messageClass}> {React.string(message)} </span>
        {React.string(beam)}
      </div>
    </div>
  }
}

@react.component
let make = () => {
  let (_shown, setShown) = React.useState(_ => false)

  <div className="flex gap-4 justify-center">
    <Screen
      content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
      options={[(React.string("Go back"), _ => setShown(prev => !prev))]}
    />
    <Terminal />
  </div>
}
