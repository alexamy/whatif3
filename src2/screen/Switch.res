type state = Visited | Unvisited

module Base = {
  type t = {update: state => unit}

  let make = (~content: Jq.t, ~initial=Unvisited) => {
    let state = ref(initial)

    let update = newState => {
      state := newState
      switch newState {
      | Visited => Jq.show(content)
      | Unvisited => Jq.hide(content)
      }
    }

    update(initial)
    {update: update}
  }
}

module Toggle = {
  type t = {update: state => unit}

  let replaceWithText = link => {
    let text = Jq.getText(link)
    link->Jq.replaceWith(Jq.string(text))
  }

  let make = (~link: Jq.t, ~content: Jq.t, ~initial=Unvisited) => {
    let base = Base.make(~content, ~initial)

    let rec update = newState => {
      base.update(newState)
      switch newState {
      | Visited => replaceWithText(link)
      | Unvisited => link->Jq.onClick(_ => update(Visited), ~options={once: true})
      }
    }

    update(initial)
    {update}
  }
}
