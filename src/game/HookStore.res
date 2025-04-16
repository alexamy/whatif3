type state<'a> = {
  value: 'a,
  update: ('a => unit) => unit,
}

let makeState = initial => {
  let value = Mobx.observable(initial)
  let update = Mobx.action1(updater => updater(value))

  {value, update}
}
