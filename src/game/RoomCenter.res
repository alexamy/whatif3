let options: array<Path.pathOptions> = [
  {element: React.string("Подойти к столу"), room: Path.RoomTable},
  {element: React.string("Подойти к окну"), room: Path.RoomWindow},
  {element: React.string("Подойти к двери"), room: Path.RoomDoor},
]

let note1Ref = ref(HookSwitch.Unvisited)

let make = (props: Path.pathProps) => {
  let note1 = HookSwitch.Toggle.useSwitch(~initial=note1Ref.contents)

  // useContext?
  React.useEffect(() => {
    note1Ref := note1.state
    None
  }, [note1.state])

  let content =
    <>
      {Utils.strings([
        "Вы стоите посреди комнаты.",
        "На вашей руке - умные часы.",
        "Вы используете их для записи и чтения заметок.",
      ])}
      {React.string(" ")}
      {note1.link(React.string("Читать заметку."))}
      {note1.content(<p> {React.string("\"Привет, мир!\"")} </p>)}
    </>

  <Screen content options goTo={props.goTo} />
}

React.setDisplayName(make, "RoomCenter")
