type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Link = {
  let render = (child: Jq.t) => {
    Jq.tree(
      #a,
      ~class="not-prose text-blue-300 hover:text-blue-400 visited:text-base",
      ~attributes=[("href", "#")],
      [child],
    )
  }

  let ref = (ref, child) => {
    Jq.ref(ref, render(Jq.tree(#span, ~ref, [Jq.string(child)])))
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
        Link.ref(note1.link, "Читать заметку."),
        Jq.Dom.newline(),
        Jq.ref(note1.content, Jq.tree(#span, [Jq.string("\"Привет, мир!\"")])),
      ],
    )
  }
}
