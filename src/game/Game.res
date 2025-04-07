@react.component
let make = () => {
  <Screen
    content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
    options={[(React.string("Go back"), _ => ())]}
  />
}
