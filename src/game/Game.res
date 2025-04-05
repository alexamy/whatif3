module Info = {
  @unboxed
  type state =
    | Start
    | Listen

  type event = GoBack | Listen

  type initialContext = unit
  type context = unit
}

module M = Robot.Make(Info)
open Info

let machine = M.createMachine(
  ~initial=Start,
  ~context=initialContext => initialContext,
  ~states=M.states([
    (Start, M.state([M.transition(~event=Listen, ~target=Listen, ~modifiers=[])])),
    (Listen, M.state([M.transition(~event=GoBack, ~target=Start, ~modifiers=[])])),
  ]),
)

type context = {}

module Start = {
  @react.component
  let make = (~send: M.send) => {
    <Screen
      content={<p> {React.string("You were chosen to participate in a secret experiment.")} </p>}
      options={[(React.string("Listen"), _ => send(Listen))]}
    />
  }
}

module Listen = {
  @react.component
  let make = (~send: M.send) => {
    <Screen
      content={<p>
        {React.string("You are listening to a recording of a person who is being tortured.")}
      </p>}
      options={[(React.string("Go back"), _ => send(GoBack))]}
    />
  }
}

@react.component
let make = () => {
  let (state, send, _) = M.useMachine(machine, ())

  switch state.name {
  | Start => <Start send />
  | Listen => <Listen send />
  }
}
