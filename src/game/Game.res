@react.component
let make = () => {
  let (current, setCurrent) = React.useState(() => Path.RoomCenter)
  let {left, right} = PathMap.get(current)

  module CurrentLeft = {
    let make = left
  }

  module CurrentRight = {
    let make = right
  }

  let goTo = room => setCurrent(_ => room)

  <div className="flex gap-4 justify-center">
    <CurrentLeft goTo />
    <CurrentRight goTo />
  </div>
}
