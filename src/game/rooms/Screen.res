type nav = {
  content: React.element,
  onClick: unit => unit,
}

@react.component
let make = (~content: React.element, ~options: array<nav>) => {
  <div className="prosy screen-w py-0">
    <article> {content} </article>
    <nav>
      <ul>
        {React.array(
          Array.mapWithIndex(options, (i, {content, onClick}) =>
            <li key={Int.toString(i)}>
              <Link onClick={onClick}> {content} </Link>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
}
