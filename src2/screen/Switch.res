type state = Visited | Unvisited

module Base = {
  type t = {content: Jq.t => Jq.t, update: state => unit, setup: unit => unit}

  let make = (~initial=Unvisited) => {
    let state = ref(initial)
    let content = ref(Jq.Dom.placeholder)

    let update = newState => {
      state := newState
      switch newState {
      | Visited => Jq.show(content.contents)
      | Unvisited => Jq.hide(content.contents)
      }
    }

    let setup = () => update(initial)

    {update, setup, content: element => Jq.ref(content, element)}
  }
}

module Toggle = {
  type t = {content: Jq.t => Jq.t, link: string => Jq.t, update: state => unit, setup: unit => unit}

  let replaceWithText = link => {
    let text = Jq.getText(link)
    link->Jq.replaceWith(Jq.string(text))
  }

  let make = (~initial=Unvisited) => {
    let base = Base.make(~initial)
    let link = ref(Jq.Dom.placeholder)

    let rec update = newState => {
      base.update(newState)
      switch newState {
      | Visited => replaceWithText(link.contents)
      | Unvisited => link.contents->Jq.onClick(_ => update(Visited), ~options={once: true})
      }
    }

    let setup = () => update(initial)

    let makeLink = text => {
      Jq.ref(link, Link.render(Jq.tree(#span, [Jq.string(text)])))
    }

    {update, setup, link: makeLink, content: base.content}
  }
}
