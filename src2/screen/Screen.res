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
      {Jqx.string(
        "Вы стоите посреди комнаты. На вашей руке - умные часы.",
      )}
      {Jqx.string(
        "Вы используете их для записи и чтения заметок.",
      )}
      {One(Jq.Dom.space())}
      {One(note1.link("Читать заметку."))}
      {One(Jq.Dom.newline())}
      {One(note1.content(Jq.makeFromString("span")))}
    </div>
  }
}
