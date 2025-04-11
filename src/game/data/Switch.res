type state = Visited | Unvisited

module Base = {
  type t = {
    state: state,
    content: React.element => React.element,
    toggle: state => unit,
  }

  let useSwitch = initial => {
    let (state, setState) = React.useState(_ => initial)

    let toggle = state => {
      setState(_ => state)
    }

    let content = children => {
      state === Visited ? children : React.null
    }

    {state, content, toggle}
  }
}

module Toggle = {
  type t = {
    link: React.element => React.element,
    content: React.element => React.element,
  }

  let useSwitch = (~initial=Unvisited) => {
    let base = Base.useSwitch(initial)
    let isVisited = base.state === Visited

    let link = children => {
      isVisited
        ? children
        : <Screen.Link onClick={_ => base.toggle(Visited)}> {children} </Screen.Link>
    }

    let content = children => {
      isVisited ? children : React.null
    }

    {link, content}
  }
}
