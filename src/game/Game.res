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
  let (current, send, _) = Robot.useMachine(machine, {count: 0})

  <>
    <article>
      <h1> {React.string("It is a story")} </h1>
      <p>
        {React.string("For years parents have espoused the health benefits of eating garlic bread with cheese to their
    children, with the food earning such an iconic status in our culture that kids will often dress
    up as warm, cheesy loaf for Halloween.")}
      </p>
      <p>
        {React.string("But a recent \n study shows that the celebrated appetizer may be linked to a series of rabies cases
    springing up around the country.")}
      </p>
      <button onClick={_ => send("next")}> {React.string("Next")} </button>
      <p> {React.string(current.name)} </p>
      <p> {React.string(Int.toString(current.context.count))} </p>
    </article>
    <nav>
      <ul>
        <li>
          <a href="#"> {React.string("Option 1")} </a>
        </li>
        <li>
          <a href="#"> {React.string("Option 2")} </a>
        </li>
        <li>
          <a href="#"> {React.string("Option 3")} </a>
        </li>
      </ul>
    </nav>
  </>
}
