let make = (props: Path.terminalProps) => {
  let display = Display.useDisplay({width: 36, height: 13})
  let input = Input.useInput({
    width: 36,
  })

  // TODO: split components
  let header = "Умные часы 3000"
  let colorClass = "bg-blue-400"

  let (highlighted, setHighlighted) = React.useState(_ => false)

  let lines = React.array(
    Array.mapWithIndex(display.lines, (line, i) =>
      <div key={Int.toString(i)}> {React.string(line)} </div>
    ),
  )

  let knownCommands = ["очистить", "помощь"]
  let processMessage = text => {
    switch String.trim(text) {
    | "очистить" => display.screen(Clear)
    | "помощь" => display.screen(Echo(["Помощь"]))
    | message if String.length(message) > 0 => display.screen(Echo([message]))
    | _ => ()
    }
  }

  let onKeyDown = e => {
    let key = JsxEvent.Keyboard.key(e)

    if String.length(key) === 1 || key === "Backspace" {
      let newMessage = input.message ++ key
      setHighlighted(_ => Array.includes(knownCommands, newMessage))
    }

    switch key {
    | "ArrowUp" => display.viewport(Up)
    | "ArrowDown" => display.viewport(Down)
    | "Backspace" => input.run(RemoveChar)
    | "Enter" => {
        processMessage(input.message)
        display.viewport(Reset)
        input.run(Clear)
      }
    | key if String.length(key) === 1 => input.run(AddChar(key))
    | _ => ()
    }
  }

  <div
    className={`
      monospace screen-w screen-h
      outline-0 whitespace-pre text-nowrap
      p-2 flex flex-col justify-between
      text-gray-800 ${colorClass}
    `}
    tabIndex=0
    onKeyDown
    onClick={_ => input.focus(On)}
    onFocus={_ => input.focus(On)}
    onBlur={_ => input.focus(Off)}>
    <div className="text-center"> {React.string(header)} </div>
    <div className="flex flex-col">
      <div className="flex flex-col grow"> {lines} </div>
      <div className="select-none">
        {React.string("> ")}
        <span className={`${highlighted ? "bg-green-800 text-white" : ""}`}>
          {React.string(input.message)}
        </span>
        {React.string(input.beam)}
      </div>
    </div>
  </div>
}
