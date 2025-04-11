type state = Visited | Unvisited

module Base = {
  type t = {content: ref<Jq.t>, update: (~newState: state=?) => unit}

  let make = (~initial=Unvisited) => {
    let state = ref(initial)
    let content = ref(Jq.Dom.null())

    let update = (~newState=initial) => {
      state := newState
      switch newState {
      | Visited => Jq.show(content.contents)
      | Unvisited => Jq.hide(content.contents)
      }
    }

    {update, content}
  }
}

module Toggle = {
  type t = {content: ref<Jq.t>, link: ref<Jq.t>, update: (~newState: state=?) => unit}

  let replaceWithText = link => {
    let text = Jq.getText(link)
    link->Jq.replaceWith(Jq.string(text))
  }

  let make = (~initial=Unvisited) => {
    let base = Base.make()
    let link = ref(Jq.Dom.null())

    let rec update = (~newState=initial) => {
      base.update(~newState)
      switch newState {
      | Visited => replaceWithText(link.contents)
      | Unvisited =>
        link.contents->Jq.onClick(_ => update(~newState=Visited), ~options={once: true})
      }
    }

    {update, link, content: base.content}
  }
}
