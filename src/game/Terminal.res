module Handwatch = {
  let header = "Умные часы 3000"
  let styleClass = "bg-blue-400"

  let knownCommands = Some(["очистить", "помощь"])
  let processMessage = ({text, display}: TerminalBase.processProps) => {
    switch text {
    | "очистить" => display.screen(Clear)
    | "помощь" => display.screen(Echo(["Помощь"]))
    | message => display.screen(Echo([message]))
    }
  }

  let make = TerminalBase.makeComponent({header, styleClass, knownCommands, processMessage})
}
