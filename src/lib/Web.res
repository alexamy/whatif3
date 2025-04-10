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

module Jq = {
  type t = Node.t

  // creation
  let make = (tag: [#div | #span | #p]) => {
    let t = Document.createElement(Document.document, tag)
    t
  }

  // manipulation
  let append = (t, node) => {
    t->Node.appendChild(node)
    t
  }

  let appendTo = (t, node) => {
    node->Node.appendChild(t)
    t
  }

  let text = (t, text) => {
    t->Node.textContent(text)
    t
  }

  // classes
  let addClass = (t, classes) => {
    let classes = String.split(classes, " ")
    t->ClassList.classList->ClassList.addClass(classes)
    t
  }

  let removeClass = (t, classes) => {
    let classes = String.split(classes, " ")
    t->ClassList.classList->ClassList.removeClass(classes)
    t
  }

  let toggleClass = (t, classes, value) => {
    let classes = String.split(classes, " ")
    Array.forEach(classes, class => t->ClassList.classList->ClassList.toggleClass(class, value))
    t
  }
}