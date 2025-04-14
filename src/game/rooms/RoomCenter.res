open Path

let meta: Path.screen = {
  room: Center,
  computer: Watch,
  options: [
    (React.string("Подойти к столу"), Table),
    (React.string("Подойти к окну"), Window),
    (React.string("Подойти к двери"), Door),
  ],
}

@react.component
let make = (~goTo) => {
  let note1 = Switch.Toggle.useSwitch()
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

  <Screen goTo content options={meta.options} />
}
