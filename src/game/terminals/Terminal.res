type color = Blue | Red

let make = (props: Path.terminalProps) => {
  let {display, screen, viewport} = Display.useDisplay({width: 36, height: 13})
  let {message, beam, input, focus} = Input.useInput({
    width: 36,
  })

  // TODO: split components
  let header = "Умные часы 3000"
  let colorClass = "bg-blue-400"

  let (highlighted, setHighlighted) = React.useState(_ => false)

  let knownCommands = ["очистить", "помощь"]
  let processMessage = text => {
    switch String.trim(text) {
    | "очистить" => screen(Clear)
    | "помощь" => screen(Echo(["Помощь"]))
    | message if String.length(message) > 0 => screen(Echo([message]))
    | _ => ()
    }
  }

  let onKeyDown = e => {
    let key = JsxEvent.Keyboard.key(e)

    if String.length(key) === 1 || key === "Backspace" {
      let newMessage = message ++ key
      setHighlighted(_ => Array.includes(knownCommands, newMessage))
    }

    switch key {
    | "ArrowUp" => viewport(Up)
    | "ArrowDown" => viewport(Down)
    | "Backspace" => input(RemoveChar)
    | "Enter" => {
        processMessage(message)
        viewport(Reset)
        input(Clear)
      }
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
    className={`
      monospace screen-w screen-h
      outline-0 whitespace-pre text-nowrap
      p-2 flex flex-col justify-between
      text-gray-800 ${colorClass}
    `}
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
        <span className={`${highlighted ? "bg-green-800 text-white" : ""}`}>
          {React.string(message)}
        </span>
        {React.string(beam)}
      </div>
    </div>
  </div>
}
