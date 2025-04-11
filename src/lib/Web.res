module Node = {
  type t
  @send external appendChild: (t, t) => unit = "appendChild"
  @send external insertBefore: (t, t, ~reference: t) => unit = "insertBefore"
  @set external setTextContent: (t, string) => unit = "textContent"
  @get external getTextContent: t => string = "textContent"
  @get external parentNode: t => t = "parentNode"
  @send external replaceChild: (t, t, t) => unit = "replaceChild"
  @send external removeChild: (t, t) => unit = "removeChild"
}

module Style = {
  type t = {@set "display": [#initial | #inline | #block | #none]}
  @get external style: Node.t => t = "style"
}

module ClassList = {
  type t
  @get external classList: Node.t => t = "classList"
  @send @variadic external add: (t, array<string>) => unit = "add"
  @send @variadic external remove: (t, array<string>) => unit = "remove"
  @send external toggle: (t, string, bool) => unit = "toggle"
}

module Document = {
  type t
  @val external document: t = "document"
  @send external querySelector: (t, string) => option<Node.t> = "querySelector"
  @send external createElement: (t, string) => Node.t = "createElement"
  @send external createTextNode: (t, string) => Node.t = "createTextNode"
}
