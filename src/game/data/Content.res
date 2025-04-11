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

module SwitchBase = {
  type state = Visited | Unvisited

  type t = {
    state: state,
    content: React.element => React.element,
    toggle: state => unit,
  }

  let useSwitch = initial => {
    let (state, setState) = React.useState(_ => initial)

    let toggle = state => {
      setState(_ => state)
    }

    let content = children => {
      state === Visited ? children : React.null
    }

    {state, content, toggle}
  }
}

module Switch = {
  type t = {
    link: React.element => React.element,
    content: React.element => React.element,
  }

  let useSwitch = (~initial=SwitchBase.Unvisited) => {
    let base = SwitchBase.useSwitch(initial)
    let isVisited = base.state === Visited

    let link = children => {
      isVisited
        ? children
        : <Screen.Link onClick={_ => base.toggle(Visited)}> {children} </Screen.Link>
    }

    let content = children => {
      isVisited ? children : React.null
    }

    {link, content}
  }
}

module Room = {
  let computer = Watch

  let paths = [
    ("Подойти к столу", Table),
    ("Подойти к окну", Window),
    ("Подойти к двери", Door),
  ]

  @react.component
  let make = (~goTo) => {
    let note1 = Switch.useSwitch()

    let options = Array.map(paths, ((option, place)) => (React.string(option), _ => goTo(place)))
    let content =
      <>
        {React.string(
          "Вы стоите посреди комнаты. На вашей руке - умные часы. Вы используете их для записи и чтения заметок.",
        )}
        {note1.link(React.string("Читать заметку"))}
        {note1.content(
          React.string("Вы читаете заметку: \"Привет, мир!\""),
        )}
      </>

    <Screen content options />
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
