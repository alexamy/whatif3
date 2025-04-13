type state = Visited | Unvisited

module Base = {
  type t = {content: Jq.t => Jq.t, update: state => unit, setup: unit => unit}

  let make = (~initial=Unvisited) => {
    let state = ref(initial)
    let content = ref(Jq.Dom.placeholder)

    let makeContent = element => {
      Jq.ref(content, element)
    }

    let update = newState => {
      state := newState
      switch newState {
      | Visited => Jq.show(content.contents)
      | Unvisited => Jq.hide(content.contents)
      }
    }

    let setup = () => update(initial)

    {update, setup, content: makeContent}
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

    let update = newState => {
      base.update(newState)
      switch newState {
      | Visited => replaceWithText(link.contents)
      | Unvisited => ()
      }
    }

    let makeLink = text => {
      <Link bind={link} onClickOnce={_ => update(Visited)}> {Jqx.string(text)} </Link>
    }

    let setup = () => update(initial)

    {update, setup, link: makeLink, content: base.content}
  }
}
