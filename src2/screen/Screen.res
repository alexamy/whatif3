type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Room = {
  @jsx.component
  let make = () => {
    let note1 = Switch.Toggle.make()
    let dependencies = [note1.setup]

    <div class="prosy screen-w py-0" dependencies>
      {Jqx.text([
        "Вы стоите посреди комнаты. На вашей руке - умные часы.",
        "Вы используете их для записи и чтения заметок.",
      ])}
      {Jqx.space()}
      {note1.link("Читать заметку.")}
      {Jqx.newline()}
      {note1.content(<span> {Jqx.string("\"Привет, мир!\"")} </span>)}
    </div>
  }
}
