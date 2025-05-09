type processProps = {
  text: string,
  display: Display.t,
  input: Input.t,
}

type constructProps = {
  header: string,
  styleClass: string,
  knownCommands: option<array<string>>,
  processMessage: processProps => unit,
}

let makeComponent = ({header, styleClass, knownCommands, processMessage}: constructProps) => (
  _: Path.props,
) => {
  let display = Display.useDisplay({width: 35, height: 14})
  let input = Input.useInput({width: 35})

  let (highlighted, setHighlighted) = React.useState(_ => false)

  let lines = React.array(
    Array.mapWithIndex(display.lines, (line, i) =>
      <div key={Int.toString(i)}> {React.string(line)} </div>
    ),
  )

  let runProcessMessage = text => {
    let text = String.trim(text)
    if String.length(text) > 0 {
      processMessage({text, display, input})
    }
  }

  let onKeyDown = e => {
    let key = JsxEvent.Keyboard.key(e)

    Option.forEach(knownCommands, commands => {
      if String.length(key) === 1 || key === "Backspace" {
        let newMessage = input.message ++ key
        setHighlighted(_ => Array.includes(commands, newMessage))
      }
    })

    switch key {
    | "ArrowUp" => display.viewport(Up)
    | "ArrowDown" => display.viewport(Down)
    | "Backspace" => input.run(RemoveChar)
    | "Enter" => {
        runProcessMessage(input.message)
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
      text-gray-800 ${styleClass}
    `}
    tabIndex=0
    onKeyDown
    onClick={_ => input.focus(On)}
    onFocus={_ => input.focus(On)}
    onBlur={_ => input.focus(Off)}>
    <div className="text-center"> {React.string(header)} </div>
    <div className="flex flex-col">
      <div className="flex flex-col grow text-md/1"> {lines} </div>
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
