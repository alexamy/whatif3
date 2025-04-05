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

let machine = Machine.createMachine(
  ~initial=Info.Start,
  ~context=initialContext => initialContext,
  ~states=Dict.fromArray([
    (
      (Info.Start :> string),
      Machine.state([Machine.transition(~event=Info.Listen, ~target=Info.Listen, ~modifiers=[])]),
    ),
    (
      (Info.Listen :> string),
      Machine.state([Machine.transition(~event=Info.GoAway, ~target=Info.GoAway, ~modifiers=[])]),
    ),
    (
      (Info.GoAway :> string),
      Machine.state([Machine.transition(~event=Info.Run, ~target=Info.Run, ~modifiers=[])]),
    ),
    (
      (Info.Run :> string),
      Machine.state([Machine.transition(~event=Info.Start, ~target=Info.Start, ~modifiers=[])]),
    ),
  ]),
)

type context = {}

module Start = {
  @react.component
  let make = (~send: event) => {
    <>
      <article>
        <p> {React.string("You were chosen to participate in a secret experiment.")} </p>
        <p> {React.string("But a recent study shows that to be a lie.")} </p>
      </article>
      <nav>
        <ul>
          <li>
            <a href="#"> {React.string("Listen")} </a>
          </li>
          <li>
            <a href="#"> {React.string("Go away")} </a>
          </li>
          <li>
            <a href="#"> {React.string("Run")} </a>
          </li>
        </ul>
      </nav>
    </>
  }
}

@react.component
let make = () => {
  let (state, send, _) = Robot.useMachine(machine, ({}: context))

  <div> {React.string(state.name)} </div>
}
