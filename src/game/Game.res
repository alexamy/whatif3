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

module Screen = {
  type nav = {
    element: React.element,
    onClick: unit => unit,
  }

  @react.component
  let make = (~content: React.element, ~options: array<nav>) => {
    <>
      <article> {content} </article>
      <nav>
        <ul>
          {React.array(
            Array.mapWithIndex(options, (i, nav) =>
              <li key={Int.toString(i)}>
                <a href="#" onClick={_ => nav.onClick()}> {nav.element} </a>
              </li>
            ),
          )}
        </ul>
      </nav>
    </>
  }
}

module Start = {
  @react.component
  let make = (~send: M.send) => {
    <Screen
      content={<p> {React.string("You were chosen to participate in a secret experiment.")} </p>}
      options={[
        {element: <p> {React.string("Listen")} </p>, onClick: _ => send(Listen)},
        {element: <p> {React.string("Go away")} </p>, onClick: _ => send(GoAway)},
        {element: <p> {React.string("Run")} </p>, onClick: _ => send(Run)},
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
      options={[{element: <p> {React.string("Go back")} </p>, onClick: _ => send(GoAway)}]}
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
