type state
type machine
type service

type event<'data, 'error> = {
  name: string,
  data: 'data,
  error?: 'error,
}

type modifier
type transition

@module("robot3") external action: (('context, event<'data, 'error>) => unit) => modifier = "action"
@module("robot3") external guard: (('context, event<'data, 'error>) => bool) => modifier = "guard"
@module("robot3")
external reduce: (('context, event<'data, 'error>) => 'context) => modifier = "reduce"

@module("robot3") @variadic
external immediate: (~target: string, ~modifiers: array<modifier>) => transition = "immediate"

@module("robot3") @variadic
external transition: (~event: string, ~target: string, ~modifiers: array<modifier>) => transition =
  "transition"

@module("robot3") @variadic
external state: array<transition> => state = "state"

@module("robot3") @variadic
external invoke: ('context => promise<'data>, array<transition>) => state = "invoke"

@module("robot3")
external createMachine: (
  ~initial: string,
  ~states: dict<state>,
  ~context: 'initialContext => 'context,
) => machine = "createMachine"

@module("robot3")
external interpret: (
  ~machine: machine,
  ~onChange: service => unit,
  ~initialContext: 'initialContext,
) => service = "interpret"

type current<'context> = {
  name: string,
  content: 'context,
}

@module("react-robot")
external useMachine: (machine, 'initialContext) => (current<'context>, 'event => unit, service) =
  "useMachine"
