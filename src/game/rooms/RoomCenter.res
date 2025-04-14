open Path

let computer = Watch

let paths = [
  (React.string("Подойти к столу"), Table),
  (React.string("Подойти к окну"), Window),
  (React.string("Подойти к двери"), Door),
]

let space = React.string(" ")

@react.component
let make = (~goTo) => {
  let note1 = Switch.Toggle.useSwitch()

  let options = Array.map(paths, ((option, place)) => (option, _ => goTo(place)))
  let content =
    <>
      {Utils.strings([
        "Вы стоите посреди комнаты.",
        "На вашей руке - умные часы.",
        "Вы используете их для записи и чтения заметок.",
      ])}
      {space}
      {note1.link(React.string("Читать заметку."))}
      {note1.content(<p> {React.string("\"Привет, мир!\"")} </p>)}
    </>

  <Screen content options />
}
