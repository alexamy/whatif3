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

module Machine = Robot.Make(Info)

open Info
let machine = Machine.createMachine(
  ~initial=Start,
  ~context=initialContext => initialContext,
  ~states=Dict.fromArray([
    (
      (Start :> string),
      Machine.state([Machine.transition(~event=Listen, ~target=Listen, ~modifiers=[])]),
    ),
    (
      (Listen :> string),
      Machine.state([Machine.transition(~event=GoAway, ~target=GoAway, ~modifiers=[])]),
    ),
    (
      (GoAway :> string),
      Machine.state([Machine.transition(~event=Run, ~target=Run, ~modifiers=[])]),
    ),
    (
      (Run :> string),
      Machine.state([Machine.transition(~event=Start, ~target=Start, ~modifiers=[])]),
    ),
  ]),
)

type context = {}

module Start = {
  @react.component
  let make = (~send: Machine.send) => {
    <>
      <article>
        <p> {React.string("You were chosen to participate in a secret experiment.")} </p>
        <p> {React.string("But a recent study shows that to be a lie.")} </p>
      </article>
      <nav>
        <ul>
          <li>
            <a href="#" onClick={_ => send(Listen)}> {React.string("Listen")} </a>
          </li>
          <li>
            <a href="#" onClick={_ => send(GoAway)}> {React.string("Go away")} </a>
          </li>
          <li>
            <a href="#" onClick={_ => send(Run)}> {React.string("Run")} </a>
          </li>
        </ul>
      </nav>
    </>
  }
}

@react.component
let make = () => {
  let (state, send, _) = Machine.useMachine(machine, ())

  switch state.name {
  | Start => <Start send />
  | Listen => <Start send />
  | GoAway => <Start send />
  | Run => <Start send />
  }
}
