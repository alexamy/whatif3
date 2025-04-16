type state = {mutable count: int, mutable options: array<Path.pathOptions>}

let store = Store.makeStore({
  count: 1,
  options: [{element: React.string("Вернуться"), room: Path.RoomCenter}],
})

let make = Mobx.observer((props: Path.pathProps) => {
  let content =
    <>
      {Utils.strings([
        "Вы стоите перед дверью.",
        "На двери находится терминал.",
      ])}
      {React.string(" ")}
      {React.string("Количество посещений: ")}
      {React.string(store.state.count->Int.toString)}
    </>

  <Screen content options={store.state.options} goTo={props.goTo} />
})

React.setDisplayName(make, "RoomDoor")
