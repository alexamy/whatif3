module Node = {
  type t
  @send external appendChild: (t, t) => unit = "appendChild"
  @send external insertBefore: (t, t, ~reference: t) => unit = "insertBefore"
  @set external textContent: (t, string) => unit = "textContent"
}

module ClassList = {
  type t
  @get external classList: Node.t => t = "classList"
  @send @variadic external addClass: (t, array<string>) => unit = "add"
  @send @variadic external removeClass: (t, array<string>) => unit = "remove"
  @send external toggleClass: (t, string, bool) => unit = "toggle"
}

module Document = {
  type t
  @val external document: t = "document"
  @send external querySelector: (t, string) => option<Node.t> = "querySelector"
  @send external createElement: (t, [#div | #span | #p]) => Node.t = "createElement"
}
