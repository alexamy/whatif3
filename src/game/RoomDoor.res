type state = {mutable count: int, mutable options: array<Path.options>}

let state = {
  count: 1,
  options: [(React.string("Выйти"), Path.RoomTable)],
}

let addOpenDoorTransition = () => {
  let exitTransition = (React.string("Выйти"), Path.RoomTable)

  let existing = Array.find(state.options, transition => transition == exitTransition)

  if Option.isNone(existing) {
    Array.push(state.options, exitTransition)
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
      {React.string(state.count->Int.toString)}
    </>

  <Screen content options={state.options} goTo={props.goTo} />
})

React.setDisplayName(make, "RoomDoor")
