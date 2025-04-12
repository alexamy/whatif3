type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Link = {
  let render = (child: Jq.t, ~ref=?) => {
    Jq.tree(
      #a,
      ~ref?,
      ~class="not-prose text-blue-300 hover:text-blue-400 visited:text-base",
      ~attributes=[("href", "#")],
      [child],
    )
  }
}

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
        Link.render(~ref=note1.link, Jq.tree(#span, [Jq.string("Читать заметку.")])),
        Jq.Dom.newline(),
        Jq.tree(#span, ~ref=note1.content, [Jq.string("\"Привет, мир!\"")]),
      ],
    )
  }
}
