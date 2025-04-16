type store<'a> = {
  state: 'a,
  update: ('a => unit) => unit,
}

let makeStore = initial => {
  let state = Mobx.observable(initial)
  let update = Mobx.action1(updater => updater(state))

  {state, update}
}
