@jsx.component
let make = (~children: Jqx.element, ~bind: ref<Jq.t>) => {
  <a
    bind
    class="not-prose text-blue-300 hover:text-blue-400 visited:text-base"
    attributes=[("href", "#")]>
    {children}
  </a>
}
