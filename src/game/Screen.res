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
          Array.mapWithIndex(options, (option, i) =>
            <li
              key={Int.toString(i)}
              className={option.hidden->Option.getOr(false) ? "hidden" : "list-item"}>
              <Link onClick={_ => goTo(option.room)}> {option.element} </Link>
            </li>
          ),
        )}
      </ul>
    </nav>
  </div>
})
