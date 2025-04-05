type nav = (React.element, unit => unit)

@react.component
let make = (~content: React.element, ~options: array<nav>) => {
  <div>
    <article> {content} </article>
    <nav>
      <ul>
        {React.array(
          Array.mapWithIndex(options, (i, (element, onClick)) =>
            <li key={Int.toString(i)}>
              <a href="#" onClick={_ => onClick()}> {element} </a>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
}
