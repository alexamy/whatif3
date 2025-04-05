module Info = {
  @unboxed
  type state =
    | Start
    | Listen
    | GoAway
    | Run

  type event = state

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
    (Listen, M.state([M.transition(~event=GoAway, ~target=Start, ~modifiers=[])])),
    (GoAway, M.state([M.transition(~event=Run, ~target=Run, ~modifiers=[])])),
    (Run, M.state([M.transition(~event=Start, ~target=Start, ~modifiers=[])])),
  ]),
)

type context = {}

module Start = {
  @react.component
  let make = (~send: M.send) => {
    <Screen
      content={<p> {React.string("You were chosen to participate in a secret experiment.")} </p>}
      options={[
        {element: React.string("Listen"), onClick: _ => send(Listen)},
        {element: React.string("Go away"), onClick: _ => send(GoAway)},
        {element: React.string("Run"), onClick: _ => send(Run)},
      ]}
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
      options={[{element: React.string("Go back"), onClick: _ => send(GoAway)}]}
    />
  }
}

@react.component
let make = () => {
  let (state, send, _) = M.useMachine(machine, ())

  switch state.name {
  | Start => <Start send />
  | Listen => <Listen send />
  | GoAway => <Start send />
  | Run => <Start send />
  }
}
