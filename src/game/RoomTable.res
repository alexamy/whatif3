type state = {mutable note1: HookSwitch.state}

let state = HookStore.makeState({
  note1: HookSwitch.Unvisited,
})

let options: array<Path.options> = [(React.string("Вернуться"), Path.RoomCenter)]

let make = Mobx.observer((props: Path.props) => {
  let note1 = HookSwitch.Toggle.useSwitch(~initial=state.value.note1)

  React.useEffect(() => {
    state.update(state => state.note1 = note1.state)
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
