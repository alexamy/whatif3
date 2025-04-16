let header = "Введите пароль для открытия двери"
let styleClass = "bg-red-400"

let knownCommands = None
let processMessage = ({text, display}: TerminalBase.processProps) => {
  switch text {
  | "1234" => display.screen(Echo(["Дверь открыта"]))
  | _ => display.screen(Echo(["Неверный пароль"]))
  }
}

let make = TerminalBase.makeComponent({header, styleClass, knownCommands, processMessage})
