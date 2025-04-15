@react.component
let make = (~content: React.element, ~options, ~goTo) => {
  <div className="prosy screen-w py-0">
    <article> {content} </article>
    <nav>
      <ul>
        {React.array(
          Array.mapWithIndex(options, ((content, room), i) =>
            <li key={Int.toString(i)}>
              <Link onClick={_ => goTo(room)}> {content} </Link>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
}
