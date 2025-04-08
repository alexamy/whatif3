@react.component
let make = () => {
  let {display, screen, viewport} = Display.useDisplay({width: 36, height: 13})
  let {message, beam, input} = Input.useInput({
    width: 36,
  })

  // bg-emerald-700 text-white
  let (messageClass, _) = React.useState(_ => "")

  let processMessage = text => {
    switch String.trim(text) {
    | "очистить" => screen(Clear)
    | message if String.length(message) > 0 => screen(Echo(message))
    | _ => ()
    }
  }

  let onKeyDown = e => {
    switch JsxEvent.Keyboard.key(e) {
    | "Enter" => {
        processMessage(message)
        viewport(Reset)
        input(Clear)
      }
    | "Backspace" => input(RemoveChar)
    | "ArrowUp" => viewport(Up)
    | "ArrowDown" => viewport(Down)
    | key if String.length(key) === 1 => input(AddChar(key))
    | _ => ()
    }
  }

  let lines = React.array(
    Array.mapWithIndex(display, (i, line) =>
      <div key={Int.toString(i)}> {React.string(line)} </div>
    ),
  )

  <div
    className="monospace screen-w screen-h outline-0 whitespace-pre text-nowrap bg-blue-400 text-gray-800 p-2 flex flex-col justify-between"
    tabIndex=0
    onKeyDown
    onClick={_ => input(Focus(true))}
    onFocus={_ => input(Focus(true))}
    onBlur={_ => input(Focus(false))}>
    <div className="text-center"> {React.string("Умные часы 3000")} </div>
    <div className="flex flex-col">
      <div className="flex flex-col grow"> {lines} </div>
      <div>
        {React.string("> ")}
        <span className={messageClass}> {React.string(message)} </span>
        {React.string(beam)}
      </div>
    </div>
  </div>
}
