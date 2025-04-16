type state = {mutable count: int, mutable options: array<Path.options>}

let state = HookStore.makeState({
  count: 1,
  options: [(React.string("Вернуться"), Path.RoomCenter)],
})

let addOpenDoorTransition = () => {
  let exitTransition = (React.string("Выйти"), Path.RoomTable)

  let existing = Array.find(state.value.options, transition => transition == exitTransition)

  if Option.isNone(existing) {
    state.update(state => Array.push(state.options, exitTransition))
  }
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
      {React.string(state.value.count->Int.toString)}
    </>

  <Screen content options={state.value.options} goTo={props.goTo} />
})

React.setDisplayName(make, "RoomDoor")
