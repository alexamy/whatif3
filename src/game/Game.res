@react.component
let make = () => {
  let (shown, setShown) = React.useState(() => false)

  <Screen
    content={<p>
      {React.string("You are hearing strange letters: B Y M N.")}
      {React.string(shown ? "s" : "g")}
    </p>}
    options={[(React.string("Go back"), _ => ())]}
  />
}
