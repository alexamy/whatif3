@react.component
let make = () => {
  let (shown, setShown) = React.useState(_ => false)

  <div className="flex border-2">
    <Screen
      content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
      options={[(React.string("Go back"), _ => setShown(prev => !prev))]}
    />
    // <Screen
    //   content={<p> {React.string("You are hearing strange letters: B Y M N.")} </p>}
    //   options={[(React.string("Go back"), _ => setShown(prev => !prev))]}
    // />
  </div>
}
