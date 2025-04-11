module Node = {
  type t
  @send external appendChild: (t, t) => unit = "appendChild"
  @send external insertBefore: (t, t, ~reference: t) => unit = "insertBefore"
  @set external textContent: (t, string) => unit = "textContent"
  @get external parentNode: t => t = "parentNode"
  @send external replaceChild: (t, t, t) => unit = "replaceChild"
  @send external removeChild: (t, t) => unit = "removeChild"
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

module Jq = {
  type t = Node.t
  type tag = [#div | #span | #p]

  // creation
  let make = (tag: tag) => {
    let t = Document.createElement(Document.document, (tag :> string))
    t
  }

  let string = text => {
    let t = Document.createTextNode(Document.document, text)
    t
  }

  // manipulation
  let append = (t, nodes) => {
    Array.forEach(nodes, node => t->Node.appendChild(node))
    t
  }

  let appendTo = (t, node) => {
    node->Node.appendChild(t)
    t
  }

  let replaceWith = (t, node) => {
    t->Node.parentNode->Node.replaceChild(t, node)
    t
  }

  let remove = t => {
    t->Node.parentNode->Node.removeChild(t)
    t
  }

  // content
  let text = (t, text) => {
    t->Node.textContent(text)
    t
  }

  // classes
  let addClass = (t, classes) => {
    let classes = String.split(classes, " ")
    t->ClassList.classList->ClassList.add(classes)
    t
  }

  let removeClass = (t, classes) => {
    let classes = String.split(classes, " ")
    t->ClassList.classList->ClassList.remove(classes)
    t
  }

  let toggleClass = (t, classes, value) => {
    let classes = String.split(classes, " ")
    Array.forEach(classes, class => t->ClassList.classList->ClassList.toggle(class, value))
    t
  }
}
