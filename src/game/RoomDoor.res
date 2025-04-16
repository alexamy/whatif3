type state = {mutable count: int}

let store = Store.makeStore({
  count: 1,
})

let options = [(React.string("Вернуться"), Path.RoomCenter)]

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

  <Screen content options goTo={props.goTo} />
})

React.setDisplayName(make, "RoomDoor")
