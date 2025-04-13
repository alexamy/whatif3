type rec data = {element: Jq.t, children: array<data>, dispose: unit => unit}
type element = One(data) | Many(array<data>)
type componentLike<'props, 'return> = 'props => 'return
type component<'props> = componentLike<'props, element>

let toJqArray: element => array<Jq.t> = element =>
  switch element {
  | One({element}) => [element]
  | Many(elements) => Array.map(elements, ({element}) => element)
  }

let array: array<element> => element = elements => {
  Many(
    Array.flatMap(elements, element =>
      switch element {
      | One(element) => [element]
      | Many(elements) => elements
      }
    ),
  )
}

let atom = element => One({element, children: [], dispose: _ => ()})
let string: string => element = text => text->Jq.string->atom
let int: int => element = number => number->Int.toString->string
let float: float => element = number => number->Float.toString->string
let null: unit => element = () => atom(Jq.Dom.null())

let text: array<string> => element = strings => strings->Array.map(string)->array
let ref: (ref<Jq.t>, element) => element = (ref, element) =>
  switch element {
  | One({element}) => atom(Jq.ref(ref, element))
  | Many([{element}]) => atom(Jq.ref(ref, element))
  | Many(_) => null()
  }

type props = {
  bind?: ref<Jq.t>,
  class?: string,
  classes?: dict<bool>,
  dependencies?: array<unit => unit>,
  attributes?: array<(string, string)>,
  children?: element,
  onClick?: Web.Event.click => unit,
  onClickOnce?: Web.Event.click => unit,
}

let make = (tag, props) => {
  let element = Jq.make(tag)
  let children = props.children->Option.mapWithDefault([], toJqArray)
  Jq.append(element, children)

  props.bind->Option.map(ref => ref := element)->ignore
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

  // TODO: dispose
  let onClickOnceHandler =
    props.onClickOnce->Option.map(onClick => Jq.onClick(element, onClick, ~options={once: true}))

  atom(element)
}
