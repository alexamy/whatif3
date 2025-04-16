let options: array<Path.options> = [(React.string("Вернуться"), Path.RoomCenter)]

let make = Mobx.observer((props: Path.props) => {
  let entry = Store.get(Path.RoomTable)
  let state = switch entry {
  | RoomTable(state) => state
  | _ => failwith("RoomTable state not found")
  }

  let note1 = HookSwitch.Toggle.useSwitch(~initial=state.note1)

  React.useEffect(() => {
    Store.update(
      Path.RoomTable,
      state =>
        switch state {
        | RoomTable(state) => state.note1 = note1.state
        | _ => failwith("RoomTable state not found")
        },
    )
    None
  }, [note1.state])

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
})

React.setDisplayName(make, "RoomTable")
