let meta: Path.screen = {
  room: Table,
  computer: Watch,
  options: [(React.string("Вернуться"), Center)],
}

let make = (props: Path.props) => {
  let content =
    <>
      {Utils.strings([
        "Вы стоите перед столом.",
        "На столе разбросаны документы, фотографии и записки.",
      ])}
    </>

  <Screen goTo={props.goTo} content options={meta.options} />
}
