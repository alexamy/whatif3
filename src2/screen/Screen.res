type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Room = {
  module Note1 = {
    let link = Jq.tree(#span, [Jq.string("Читать заметку.")])
    let content = Jq.tree(#span, [Jq.string("\"Привет, мир!\"")])

    let note = Switch.Toggle.useSwitch(~link, ~content)
  }

  let render = () => {
    Jq.tree(
      #div,
      [
        Jq.strings([
          "Вы стоите посреди комнаты. На вашей руке - умные часы.",
          "Вы используете их для записи и чтения заметок.",
        ]),
        Jq.Dom.space(),
        Note1.link,
        Jq.Dom.newline(),
        Note1.content,
      ],
    )
  }
}
