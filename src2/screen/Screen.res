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
        note1.link("Читать заметку."),
        Jq.Dom.newline(),
        note1.content(Jq.tree(#span, [Jq.string("\"Привет, мир!\"")])),
      ],
    )
  }
}
