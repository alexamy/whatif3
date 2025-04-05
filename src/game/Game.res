let machine = Robot.createMachine(
  ~initial="start",
  ~context=initialContext => initialContext,
  ~states=Dict.fromArray([
    ("start", Robot.state([Robot.transition(~event="next", ~target="next", ~modifiers=[])])),
    ("next", Robot.state([Robot.transition(~event="next", ~target="next", ~modifiers=[])])),
  ]),
)

type context = {count: int}

@react.component
let make = () => {
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
