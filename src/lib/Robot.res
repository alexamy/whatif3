module type MachineInfo = {
  type event
  type state

  type initialContext
  type context
}

module Make = (Info: MachineInfo) => {
  type state
  type states
  type machine
  type service

  type event<'data, 'error> = {
    name: Info.event,
    data: 'data,
    error?: 'error,
  }

  type modifier
  type transition

  @module("robot3")
  external action: ((Info.context, event<'data, 'error>) => unit) => modifier = "action"
  @module("robot3")
  external guard: ((Info.context, event<'data, 'error>) => bool) => modifier = "guard"
  @module("robot3")
  external reduce: ((Info.context, event<'data, 'error>) => Info.context) => modifier = "reduce"

  @module("robot3") @variadic
  external immediate: (~target: Info.state, ~modifiers: array<modifier>) => transition = "immediate"

  @module("robot3") @variadic
  external transition: (
    ~event: Info.event,
    ~target: Info.state,
    ~modifiers: array<modifier>,
  ) => transition = "transition"

  @module("robot3") @variadic
  external state: array<transition> => state = "state"

  @module("robot3") @variadic
  external invoke: (Info.context => promise<'data>, array<transition>) => state = "invoke"

  @module("robot3")
  external createMachine: (
    ~initial: Info.state,
    ~states: states,
    ~context: Info.initialContext => Info.context,
  ) => machine = "createMachine"

  @module("robot3")
  external interpret: (
    ~machine: machine,
    ~onChange: service => unit,
    ~initialContext: Info.initialContext,
  ) => service = "interpret"

  type current = {
    name: Info.state,
    context: Info.context,
  }
  type send = Info.event => unit
  type hook = (current, send, service)

  @module("react-robot")
  external useMachine: (machine, Info.initialContext) => hook = "useMachine"

  external _toStatePairs: array<(Info.state, state)> => array<(string, state)> = "%identity"
  external _toStates: dict<state> => states = "%identity"

  let states = (pairs: array<(Info.state, state)>): states => {
    pairs->_toStatePairs->Dict.fromArray->_toStates
  }
}
