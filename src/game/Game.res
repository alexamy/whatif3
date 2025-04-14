@react.component
let make = () => {
  // let (current, setCurrent) = React.useState(_ => 0)
  // let data = React.useMemo(() => Content.screens[current]->Option.getUnsafe, [current])

  // let findNext = place => {
  //   let index = Array.getIndexBy(Content.screens, screen => screen.place === place)
  //   switch index {
  //   | Some(index) => setCurrent(_ => index)
  //   | None => Error.panic("No next screen found")
  //   }
  // }

  // let content = <p> {React.string("Placeholder")} </p>
  // let options = Array.map(data.options, ((option, place)) => (
  //   React.string(option),
  //   _ => findNext(place),
  // ))

  // let computer = switch data.computer {
  // | Watch => <Terminal color=Blue header="Умные часы 3000" />
  // | Door => <Terminal color=Red header="Введите код для открытия двери" />
  // }

  <div className="flex gap-4 justify-center">
    <RoomCenter goTo={_ => ()} />
    <Terminal color=Blue header="Умные часы 3000" />
  </div>
}
