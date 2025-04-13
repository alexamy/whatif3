module Node = {
  type t
  @send external appendChild: (t, t) => unit = "appendChild"
  @send external insertBefore: (t, t, ~reference: t) => unit = "insertBefore"
  @set external setTextContent: (t, string) => unit = "textContent"
  @get external getTextContent: t => string = "textContent"
  @get external parentNode: t => t = "parentNode"
  @send external replaceChild: (t, ~new: t, ~old: t) => unit = "replaceChild"
  @send external removeChild: (t, t) => unit = "removeChild"
  @send external setAttribute: (t, string, string) => unit = "setAttribute"
}

module Event = {
  type handler

  type options = {once: bool}

  type click = {
    clientX: int,
    clientY: int,
    pageX: int,
    pageY: int,
    screenX: int,
    screenY: int,
    button: int,
  }

  external dangerousToGenericHandler: ('a => unit) => handler = "%identity"

  // TODO: preventDefault
  @send external addEventListener: (Node.t, string, handler, options) => unit = "addEventListener"
  @send external removeEventListener: (Node.t, string, handler) => unit = "removeEventListener"

  let addClickListener = (node, handler: click => unit, ~options) => {
    let handler = dangerousToGenericHandler(handler)
    addEventListener(node, "click", handler, options)
    handler
  }

  let removeClickListener = (node, handler) => {
    removeEventListener(node, "click", handler)
  }
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
