@jsx.component
let make = (~children: Jqx.element, ~bind: ref<Jq.t>, ~onClickOnce: Web.Event.click => unit) => {
  <a
    bind
    onClickOnce
    class="not-prose text-blue-300 hover:text-blue-400 visited:text-base"
    attributes=[("href", "#")]>
    {children}
  </a>
}
