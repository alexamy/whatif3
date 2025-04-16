type state<'a> = {
  value: 'a,
  update: ('a => unit) => unit,
}

let makeState = (initial, ~key: Path.room) => {
  let value = Mobx.observable(initial)
  let update = Mobx.action1(updater => updater(value))

  Mobx.autorun(() => {
    Console.log2(key, Mobx.toJS(value))
  })

  {value, update}
}
