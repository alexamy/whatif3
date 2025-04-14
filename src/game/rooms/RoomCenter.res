let options = [
  (React.string("Подойти к столу"), Path.Table),
  (React.string("Подойти к окну"), Path.Window),
  (React.string("Подойти к двери"), Path.Door),
]

let note1 = ref(Switch.Unvisited)

let make = (props: Path.props) => {
  let note1 = Switch.Toggle.useSwitch(~ref=note1)

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
