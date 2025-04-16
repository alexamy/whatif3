let options: array<Path.pathOptions> = [
  {element: React.string("Вернуться"), room: Path.RoomCenter},
]

let make = (props: Path.pathProps) => {
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
