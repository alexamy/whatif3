exception NotFound(Path.room)
exception AlreadyExists(Path.room)

type info = {
  room: Path.room,
  path: Path.props => React.element,
  terminal: Terminal.props => React.element,
}

let map: Map.t<Path.room, info> = Map.make()

let get = current =>
  switch Map.get(map, current) {
  | Some(make) => make
  | None => raise(NotFound(current))
  }

let set = info => {
  let existing = Map.get(map, info.room)
  switch existing {
  | Some(_) => raise(AlreadyExists(info.room))
  | None => Map.set(map, info.room, info)
  }
}
