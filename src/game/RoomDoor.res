let addOpenDoorTransition = () => {
  let exitTransition = (React.string("Выйти"), Path.RoomTable)

  Store.update(Path.RoomDoor, state =>
    switch state {
    | RoomDoor(state) => {
        let existing = Array.find(state.options, transition => transition == exitTransition)
        if Option.isNone(existing) {
          Array.push(state.options, exitTransition)
        }
      }
    | _ => failwith("RoomDoor state not found")
    }
  )
}

let make = Mobx.observer((props: Path.props) => {
  let entry = Store.get(Path.RoomDoor)
  let state = switch entry {
  | RoomDoor(state) => state
  | _ => failwith("RoomDoor state not found")
  }

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
