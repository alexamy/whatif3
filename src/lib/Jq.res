open Web

type t = Node.t
type tag = [#div | #span | #p | #a]

module Cn = {
  let normalize = classes => {
    String.split(classes, " ")
  }
}

// creation
let make = (tag: tag) => {
  Document.createElement(Document.document, (tag :> string))
}

let string = text => {
  Document.createTextNode(Document.document, text)
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
  let classes = Cn.normalize(classes)
  t->ClassList.classList->ClassList.add(classes)
  t
}

let removeClass = (t, classes) => {
  let classes = Cn.normalize(classes)
  t->ClassList.classList->ClassList.remove(classes)
  t
}

let toggleClass = (t, classes, value) => {
  classes
  ->Cn.normalize
  ->Array.forEach(class => t->ClassList.classList->ClassList.toggle(class, value))
  t
}
