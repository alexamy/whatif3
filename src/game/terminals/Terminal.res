module RoomDoorTerminal = {
  let header = "Введите пароль для открытия двери"
  let styleClass = "bg-red-400"

  let knownCommands = None
  let processMessage = ({text, display}: TerminalBase.processProps) => {
    switch String.trim(text) {
    | "1234" => display.screen(Echo(["Дверь открыта"]))
    | message if String.length(message) > 0 => display.screen(Echo([message]))
    | _ => ()
    }
  }

  let make = TerminalBase.makeComponent({header, styleClass, knownCommands, processMessage})
}

module Handwatch = {
  let header = "Умные часы 3000"
  let styleClass = "bg-blue-400"

  let knownCommands = Some(["очистить", "помощь"])
  let processMessage = ({text, display}: TerminalBase.processProps) => {
    switch String.trim(text) {
    | "очистить" => display.screen(Clear)
    | "помощь" => display.screen(Echo(["Помощь"]))
    | message if String.length(message) > 0 => display.screen(Echo([message]))
    | _ => ()
    }
  }

  let make = TerminalBase.makeComponent({header, styleClass, knownCommands, processMessage})
}
