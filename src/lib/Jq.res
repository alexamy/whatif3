open Web

type t = Jq(Node.t)
type tag = [#div | #span | #p | #a]

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

let fromElement = element => {
  Jq(element)
}

let toElement = (Jq(element)) => {
  element
}

// manipulation
let append = (t, nodes) => {
  let Jq(element) = t
  Array.forEach(nodes, node => element->Node.appendChild(node))
  t
}

let appendTo = (t, node) => {
  let Jq(element) = t
  node->Node.appendChild(element)
  t
}

let replaceWith = (t, node) => {
  let Jq(element) = t
  element->Node.parentNode->Node.replaceChild(element, node)
  t
}

let remove = t => {
  let Jq(element) = t
  element->Node.parentNode->Node.removeChild(element)
  t
}

// content
let text = (t, text) => {
  let Jq(element) = t
  element->Node.textContent(text)
  t
}

// classes
let addClass = (t, classes) => {
  let Jq(element) = t
  let classes = Cn.normalize(classes)
  element->ClassList.classList->ClassList.add(classes)
  t
}

let removeClass = (t, classes) => {
  let Jq(element) = t
  let classes = Cn.normalize(classes)
  element->ClassList.classList->ClassList.remove(classes)
  t
}

let toggleClass = (t, classes, value) => {
  let Jq(element) = t
  let classes = Cn.normalize(classes)
  Array.forEach(classes, class => element->ClassList.classList->ClassList.toggle(class, value))
  t
}

let toggleClasses = (t, classes) => {
  let entries = Js.Dict.entries(classes)
  Array.forEach(entries, ((class, isEnabled)) => toggleClass(t, class, isEnabled)->ignore)
  t
}
