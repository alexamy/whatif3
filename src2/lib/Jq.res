open Web

@unboxed
type t = Jq(Node.t)
type tag = [#div | #span | #p | #a | #br]

module Cn = {
  let normalize = classes => {
    String.split(classes, " ")
  }

  let fromObject = obj => {
    Js.Dict.entries(obj)
    ->Array.map(((class, value)) => value ? class : "")
    ->Array.reduce("", (classes, class) => classes ++ " " ++ class)
  }
}
// creation
let make = (tag: tag) => {
  Jq(Document.createElement(Document.document, (tag :> string)))
}

let string = text => {
  Jq(Document.createTextNode(Document.document, text))
}

let fromNode = node => {
  Jq(node)
}

let toNode = t => {
  let Jq(node) = t
  node
}

// manipulation
let append = (Jq(node), nodes) => {
  Array.forEach(nodes, (Jq(other)) => {
    node->Node.appendChild(other)
  })
}

let appendTo = (Jq(node), Jq(other)) => {
  other->Node.appendChild(node)
}

let replaceWith = (Jq(node), Jq(other)) => {
  node->Node.parentNode->Node.replaceChild(~new=other, ~old=node)
}

let remove = (Jq(node)) => {
  node->Node.parentNode->Node.removeChild(node)
}

// content
let setText = (Jq(node), text) => {
  node->Node.setTextContent(text)
}

let getText = (Jq(node)) => {
  node->Node.getTextContent
}

let setAttribute = (Jq(node), name, value) => {
  node->Node.setAttribute(name, value)
}

// classes
let addClass = (Jq(node), classes) => {
  let classes = Cn.normalize(classes)
  node->ClassList.classList->ClassList.add(classes)
}

let removeClass = (Jq(node), classes) => {
  let classes = Cn.normalize(classes)
  node->ClassList.classList->ClassList.remove(classes)
}

let toggleClass = (Jq(node), classes, value) => {
  let classes = Cn.normalize(classes)
  Array.forEach(classes, class => node->ClassList.classList->ClassList.toggle(class, value))
}

let toggleClasses = (t, classes) => {
  let entries = Js.Dict.entries(classes)
  Array.forEach(entries, ((class, isEnabled)) => toggleClass(t, class, isEnabled)->ignore)
}

// display
let show = (Jq(node)) => {
  let style = node->Style.style
  style["display"] = #initial
}

let hide = (Jq(node)) => {
  let style = node->Style.style
  style["display"] = #none
}

// events
let onClick = (Jq(node), handler, ~options: option<Event.options>=?) => {
  let options = Option.getWithDefault(options, {once: false})
  Event.addClickListener(node, handler, ~options)
}

// helpers
let strings = strings => {
  strings->Array.joinWith(" ", x => x)->string
}

let withRef = (ref, element) => {
  ref := element
  element
}

let tree = (tag, children, ~ref=?, ~class=?, ~classes=?, ~dependencies=?, ~attributes=?) => {
  let element = make(tag)
  append(element, children)

  ref->Option.map(ref => ref := element)->ignore
  class->Option.map(class => addClass(element, class))->ignore
  classes->Option.map(classes => toggleClasses(element, classes))->ignore

  dependencies
  ->Option.map(dependencies => Array.forEach(dependencies, dependency => dependency()))
  ->ignore

  attributes
  ->Option.map(attributes =>
    Array.forEach(attributes, ((name, value)) => setAttribute(element, name, value))
  )
  ->ignore

  element
}

// primitives
module Dom = {
  let null = () => string("")
  let space = () => string(" ")
  let newline = () => make(#br)

  let placeholder: t = %raw(`new Proxy({}, {
    get(target, prop) {
      throw new Error("Placeholder access is not allowed! Assign ref first.")
    }
  })`)
}
