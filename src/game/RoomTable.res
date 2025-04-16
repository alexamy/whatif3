let options: array<Path.options> = [(React.string("Вернуться"), Path.RoomCenter)]

let make = (props: Path.props) => {
  let content =
    <>
      {Utils.strings([
        "Вы стоите перед столом.",
        "На столе разбросаны документы, фотографии и записки.",
      ])}
    </>

  <Screen content options goTo={props.goTo} />
}

React.setDisplayName(make, "RoomTable")
