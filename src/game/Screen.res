@react.component
let make = Mobx.observer((
  ~content: React.element,
  ~options: array<Path.options>,
  ~goTo: Path.room => unit,
) => {
  <div className="prosy screen-w py-0">
    <article> {content} </article>
    <nav>
      <ul>
        {React.array(
          Array.mapWithIndex(options, ((element, room), i) =>
            <li key={Int.toString(i)}>
              <Link onClick={_ => goTo(room)}> {element} </Link>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
})
