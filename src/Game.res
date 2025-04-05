@react.component
let make = () => {
  <Story.Text>
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
  </Story.Text>
}
