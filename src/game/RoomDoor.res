type state = {mutable count: int, mutable options: array<Path.options>}

let store = Store.makeStore({
  count: 1,
  options: [{element: React.string("Вернуться"), room: Path.RoomCenter}],
})

let openDoorTransition = () => {
  let target = Path.RoomTable
  store.update(state => {
    if Array.find(state.options, option => option.room == target) == None {
      Array.push(state.options, {element: React.string("Выйти"), room: target})
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
