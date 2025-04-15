let options = [(React.string("Вернуться"), Path.Center)]

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

PathMap.set({room: Path.Table, path: make, terminal: Terminal.make})
