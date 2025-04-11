module Toggle = {
  type state = Visited | Unvisited
  type t = {toggle: state => unit}

  let replaceWithText = link => {
    let text = Jq.getText(link)
    Jq.replaceWith(link, Jq.string(text))
  }

  let useSwitch = (~link: Jq.t, ~content: Jq.t, ~initial=Unvisited) => {
    let state = ref(initial)

    let rec update = newState => {
      state := newState
      switch newState {
      | Visited => {
          replaceWithText(link)
          Jq.show(content)
        }
      | Unvisited => {
          Jq.hide(content)
          link->Jq.onClick(_ => update(Visited), ~options={once: true})
        }
      }
    }

    update(initial)

    {toggle: update}
  }
}
