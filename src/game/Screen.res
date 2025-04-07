module Link = {
  @react.component
  let make = (~onClick: unit => unit, ~children: React.element) => {
    <a href="#" onClick={_ => onClick()}> {children} </a>
  }
}

type nav = (React.element, unit => unit)

@react.component
let make = (~content: React.element, ~options: array<nav>) => {
  <div className="prosy py-0">
    <article> {content} </article>
    <nav>
      <ul>
        {React.array(
          Array.mapWithIndex(options, (i, (element, onClick)) =>
            <li key={Int.toString(i)}>
              <Link onClick={onClick}> {element} </Link>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
}
