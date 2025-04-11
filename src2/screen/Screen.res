type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

module Switch = {
  type state = Visited | Unvisited
  type t = {toggle: state => unit}

  let replaceWithText = link => {
    let text = Jq.getText(link)
    Jq.replaceWith(link, Jq.string(text))
  }

  let useSwitch = (~link: Jq.t, ~content: Jq.t, ~initial=Unvisited) => {
    let state = ref(initial)

    let update = newState => {
      state := newState
      switch newState {
      | Visited => {
          replaceWithText(link)
          Jq.show(content)
        }
      // add click listener
      | Unvisited => Jq.hide(content)
      }
    }

    update(initial)

    {toggle: update}
  }
}

module Room = {
  module Note1 = {
    let link = Jq.tree(#span, [Jq.string("Читать заметку.")])
    let content = Jq.tree(#span, [Jq.string("\"Привет, мир!\"")])

    let note = Switch.useSwitch(~link, ~content)
    link->Jq.onClick(_ => note.toggle(Visited), ~options={once: true})
  }

  let render = () => {
    Jq.tree(
      #div,
      [
        Jq.string(
          "Вы стоите посреди комнаты. На вашей руке - умные часы. Вы используете их для записи и чтения заметок.",
        ),
        Jq.Dom.space(),
        Note1.link,
        Jq.Dom.newline(),
        Note1.content,
      ],
    )
  }
}