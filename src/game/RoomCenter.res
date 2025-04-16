let options: array<Path.options> = [
  (React.string("Подойти к столу"), Path.RoomTable),
  (React.string("Подойти к окну"), Path.RoomWindow),
  (React.string("Подойти к двери"), Path.RoomDoor),
]

let make = (props: Path.props) => {
  let content =
    <>
      {Utils.strings([
        "Вы стоите посреди комнаты.",
        "На вашей руке - умные часы.",
        "Вы используете их для записи и чтения заметок.",
      ])}
      {React.string(" ")}
    </>

  <Screen content options goTo={props.goTo} />
}

React.setDisplayName(make, "RoomCenter")
