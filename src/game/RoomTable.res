let options: array<Path.options> = [(React.string("Вернуться"), Path.RoomCenter)]

let make = (props: Path.props) => {
  let note1 = HookSwitch.Toggle.useSwitch(~initial=HookSwitch.Unvisited)

  let content =
    <>
      {Utils.strings([
        "Вы стоите перед столом.",
        "На столе разбросаны документы, фотографии и записки.",
      ])}
      {note1.link(React.string("Читать заметку."))}
      {note1.content(<p> {React.string("\"Привет, мир!\"")} </p>)}
    </>

  <Screen content options goTo={props.goTo} />
}

React.setDisplayName(make, "RoomTable")
