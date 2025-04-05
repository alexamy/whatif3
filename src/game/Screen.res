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
