type t = {
  ref?: ref<Jq.t>,
  class?: string,
  classes?: dict<bool>,
  dependencies?: array<unit => unit>,
  attributes?: array<(string, string)>,
  children?: Jqx.element,
}

let make = (tag, props) => {
  let element = Jq.make(tag)
  let children = props.children->Option.mapWithDefault([], Jqx.fromElement)
  Jq.append(element, children)

  props.ref->Option.map(ref => ref := element)->ignore
  props.class->Option.map(class => Jq.addClass(element, class))->ignore
  props.classes->Option.map(classes => Jq.toggleClasses(element, classes))->ignore

  props.dependencies
  ->Option.map(dependencies => Array.forEach(dependencies, dependency => dependency()))
  ->ignore

  props.attributes
  ->Option.map(attributes =>
    Array.forEach(attributes, ((name, value)) => Jq.setAttribute(element, name, value))
  )
  ->ignore

  element
}
