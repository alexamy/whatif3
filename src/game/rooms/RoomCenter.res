type state = {mutable note1: Switch.state}

let options = [
  (React.string("Подойти к столу"), Path.Table),
  (React.string("Подойти к окну"), Path.Window),
  (React.string("Подойти к двери"), Path.Door),
]

let state = {
  note1: Unvisited,
}

let make = (props: Path.props) => {
  let note1 = Switch.Toggle.useSwitch(~initial=state.note1, ~onToggle=_ => {
    state.note1 = Visited
  })

  let content =
    <>
      {Utils.strings([
        "Вы стоите посреди комнаты.",
        "На вашей руке - умные часы.",
        "Вы используете их для записи и чтения заметок.",
      ])}
      {React.string(" ")}
      {note1.link(React.string("Читать заметку."))}
      {note1.content(<p> {React.string("\"Привет, мир!\"")} </p>)}
    </>

  <Screen content options goTo={props.goTo} />
}
