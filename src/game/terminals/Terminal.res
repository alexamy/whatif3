type color = Blue | Red

@react.component
let make = () => {
  let {display, screen, viewport} = Display.useDisplay({width: 36, height: 13})
  let {message, beam, input, focus} = Input.useInput({
    width: 36,
  })

  // TODO: split components
  let header = "Умные часы 3000"
  let colorClass = "bg-blue-400"

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
    Array.mapWithIndex(display, (line, i) =>
      <div key={Int.toString(i)}> {React.string(line)} </div>
    ),
  )

  <div
    className={`monospace screen-w screen-h ${colorClass} outline-0 whitespace-pre text-nowrap  text-gray-800 p-2 flex flex-col justify-between`}
    tabIndex=0
    onKeyDown
    onClick={_ => focus(On)}
    onFocus={_ => focus(On)}
    onBlur={_ => focus(Off)}>
    <div className="text-center"> {React.string(header)} </div>
    <div className="flex flex-col">
      <div className="flex flex-col grow"> {lines} </div>
      <div>
        {React.string("> ")}
        <span> {React.string(message)} </span>
        {React.string(beam)}
      </div>
    </div>
  </div>
}
