@react.component
let make = (~onClick: unit => unit, ~children: React.element) => {
  <a
    href="#"
    className="not-prose  text-blue-300 hover:text-blue-400 visited:text-base"
    onClick={_ => onClick()}>
    {children}
  </a>
}
