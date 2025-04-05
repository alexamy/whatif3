@unboxed
type screen =
  | Start
  | Listen
  | GoAway
  | Run

type event = screen

let machine = Robot.createMachine(
  ~initial=(Start :> string),
  ~context=initialContext => initialContext,
  ~states=Dict.fromArray([
    (
      (Start :> string),
      Robot.state([
        Robot.transition(~event=(Listen :> string), ~target=(Listen :> string), ~modifiers=[]),
      ]),
    ),
    (
      (Listen :> string),
      Robot.state([
        Robot.transition(~event=(GoAway :> string), ~target=(GoAway :> string), ~modifiers=[]),
      ]),
    ),
    (
      (GoAway :> string),
      Robot.state([
        Robot.transition(~event=(Run :> string), ~target=(Run :> string), ~modifiers=[]),
      ]),
    ),
    (
      (Run :> string),
      Robot.state([
        Robot.transition(~event=(Start :> string), ~target=(Start :> string), ~modifiers=[]),
      ]),
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
