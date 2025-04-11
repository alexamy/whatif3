type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

type screen = {
  place: place,
  computer: computer,
  description: string,
  options: array<(string, place)>,
}

module Room = {
  let computer = Watch

  let paths = [
    ("Подойти к столу", Table),
    ("Подойти к окну", Window),
    ("Подойти к двери", Door),
  ]

  let space = React.string(" ")

  @react.component
  let make = (~goTo) => {
    let note1 = Switch.Toggle.useSwitch()

    let options = Array.map(paths, ((option, place)) => (React.string(option), _ => goTo(place)))
    let content =
      <>
        {React.string(
          "Вы стоите посреди комнаты. На вашей руке - умные часы. Вы используете их для записи и чтения заметок.",
        )}
        {space}
        {note1.link(React.string("Читать заметку."))}
        {note1.content(<p> {React.string("\"Привет, мир!\"")} </p>)}
      </>

    <Screen content options />
  }
}

module RoomD = {
  let render = () => {
    Jq.make(#div)->Jq.append([
      Jq.string(
        "Вы стоите посреди комнаты. На вашей руке - умные часы. Вы используете их для записи и чтения заметок.",
      ),
      Jq.Dom.space(),
      Jq.string("Читать заметку."),
      Jq.string("\"Привет, мир!\""),
    ])
  }
}

let screens = [
  {
    place: Table,
    computer: Watch,
    description: "Вы стоите у стола. На столе в беспорядке лежат заметки, ручки, бумажки и прочие предметы.",
    options: [("Вернуться", Room)],
  },
  {
    place: Window,
    computer: Watch,
    description: "Вы стоите у окна. За окном - улица, на которой виднеются машины и люди.",
    options: [("Вернуться", Room)],
  },
  {
    place: Door,
    computer: Door,
    description: "Вы стоите у двери. На двери надпись: \"Выход\", а также электронный код-замок. Дверь заперта.",
    options: [("Вернуться", Room)],
  },
]
