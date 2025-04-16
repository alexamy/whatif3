module StateDef = {
  type t = {mutable count: int}

  let default = {
    count: 1,
  }
}

module State = Store.MakeState(StateDef)

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
      {React.string(State.state.count->Int.toString)}
    </>

  <Screen content options goTo={props.goTo} />
})

React.setDisplayName(make, "RoomDoor")
