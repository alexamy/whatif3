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
let append = (t, nodes) => {
  let Jq(node) = t
  Array.forEach(nodes, (Jq(other)) => {
    node->Node.appendChild(other)
  })
  t
}

let appendTo = (t, Jq(other)) => {
  let Jq(node) = t
  other->Node.appendChild(node)
  t
}

let replaceWith = (t, Jq(other)) => {
  let Jq(node) = t
  node->Node.parentNode->Node.replaceChild(~new=other, ~old=node)
  t
}

let remove = t => {
  let Jq(node) = t
  node->Node.parentNode->Node.removeChild(node)
  t
}

// content
let setText = (t, text) => {
  let Jq(node) = t
  node->Node.setTextContent(text)
  t
}

let getText = t => {
  let Jq(node) = t
  node->Node.getTextContent
}

// classes
let addClass = (t, classes) => {
  let Jq(node) = t
  let classes = Cn.normalize(classes)
  node->ClassList.classList->ClassList.add(classes)
  t
}

let removeClass = (t, classes) => {
  let Jq(node) = t
  let classes = Cn.normalize(classes)
  node->ClassList.classList->ClassList.remove(classes)
  t
}

let toggleClass = (t, classes, value) => {
  let Jq(node) = t
  let classes = Cn.normalize(classes)
  Array.forEach(classes, class => node->ClassList.classList->ClassList.toggle(class, value))
  t
}

let toggleClasses = (t, classes) => {
  let entries = Js.Dict.entries(classes)
  Array.forEach(entries, ((class, isEnabled)) => toggleClass(t, class, isEnabled)->ignore)
  t
}

// display
let show = t => {
  let Jq(node) = t
  let style = node->Style.style
  style["display"] = #initial
  t
}

let hide = t => {
  let Jq(node) = t
  let style = node->Style.style
  style["display"] = #none
  t
}

// events
let onClick = (t, handler) => {
  %todo("node->Node.addEventListener(\"click\", handler)")
}

// primitives
module Dom = {
  let space = () => string(" ")
  let newline = () => make(#br)
}
