let options = [(React.string("Вернуться"), Path.RoomCenter)]

let make = (props: Path.roomProps) => {
  let content =
    <>
      {Utils.strings([
        "Вы стоите перед дверью.",
        "На двери находится терминал.",
      ])}
    </>

  <Screen content options goTo={props.goTo} />
}
