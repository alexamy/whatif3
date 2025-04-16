type state = {mutable count: int, mutable options: array<Path.options>}

let store = Store.makeStore({
  count: 1,
  options: [(React.string("Вернуться"), Path.RoomCenter)],
})

let addOpenDoorTransition = () => {
  let exitTransition = (React.string("Выйти"), Path.RoomTable)

  store.update(state => {
    let existing = Array.find(state.options, transition => transition == exitTransition)
    if Option.isNone(existing) {
      Array.push(state.options, exitTransition)
    }
  })
}

let make = Mobx.observer((props: Path.props) => {
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
