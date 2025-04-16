module type State = {
  type t
  let default: t
}

module MakeState = (State: State) => {
  let state = Mobx.observable(State.default)
  let update = Mobx.action1(updater => updater(state))
}
