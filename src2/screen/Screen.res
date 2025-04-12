type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Room = {
  let render = () => {
    let note1 = Switch.Toggle.make()

    let dependencies = [note1.setup]

    Jq.tree(
      #div,
      ~class="prosy screen-w py-0",
      ~dependencies,
      [
        Jq.strings([
          "Вы стоите посреди комнаты. На вашей руке - умные часы.",
          "Вы используете их для записи и чтения заметок.",
        ]),
        Jq.Dom.space(),
        Jq.tree(#span, ~ref=note1.link, [Jq.string("Читать заметку.")]),
        Jq.Dom.newline(),
        Jq.tree(#span, ~ref=note1.content, [Jq.string("\"Привет, мир!\"")]),
      ],
    )
  }
}
