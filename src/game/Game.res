module Info = {
  @unboxed
  type state =
    | Start
    | Listen
    | ListenToRecording

  type event = GoBack | Listen | ListenToRecording

  type initialContext = unit
  type context = {count: int}
}

module M = Robot.Make(Info)
open Info

let machine = M.createMachine(
  ~initial=Start,
  ~context=_ => {count: 0},
  ~states=M.states([
    (Start, M.state([M.transition(~event=Listen, ~target=Listen, ~modifiers=[])])),
    (
      Listen,
      M.state([
        M.transition(~event=GoBack, ~target=Start, ~modifiers=[]),
        M.transition(~event=ListenToRecording, ~target=ListenToRecording, ~modifiers=[]),
      ]),
    ),
    (ListenToRecording, M.state([M.transition(~event=GoBack, ~target=Start, ~modifiers=[])])),
  ]),
)

module Start = {
  @react.component
  let make = (~state: M.current, ~send: M.send) => {
    <Screen
      content={<p> {React.string("You were chosen to participate in a secret experiment.")} </p>}
      options={[(React.string("Listen"), _ => send(Listen))]}
    />
  }
}

module Listen = {
  @react.component
  let make = (~state: M.current, ~send: M.send) => {
    <Screen
      content={<p>
        {React.string("You are listening to a recording of a person who is being tortured.")}
      </p>}
      options={[
        (React.string("Listen to the recording"), _ => send(ListenToRecording)),
        (React.string("Go back"), _ => send(GoBack)),
      ]}
    />
  }
}

module ListenToRecording = {
  @react.component
  let make = (~state: M.current, ~send: M.send) => {
    <Screen
      content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
      options={[(React.string("Go back"), _ => send(GoBack))]}
    />
  }
}

@react.component
let make = () => {
  let (state, send, _) = M.useMachine(machine, ())

  switch state.name {
  | Start => <Start state send />
  | Listen => <Listen state send />
  | ListenToRecording => <ListenToRecording state send />
  }
}
