type t

@module("cash-dom")
external createElement: @string [@as("<div>") #div] => t = "default"

@module("cash-dom")
external wrapElement: Dom.element => t = "default"

@send external text: (t, string) => t = "text"
@send external addClass: (t, string) => t = "addClass"
@send external removeClass: (t, string) => t = "removeClass"
@send external hide: t => t = "hide"
@send external show: t => t = "show"
@send external append: (t, t) => t = "append"
@send external appendTo: (t, t) => t = "appendTo"

type eventHandler

type keydownEvent = {
  preventDefault: unit => unit,
  stopPropagation: unit => unit,
  target: Dom.element,
  key: string,
}

@send external on: (t, [#keydown], eventHandler) => t = "on"

external dangerousToEventHandler: ('a => unit) => eventHandler = "%identity"

let onKeyDown = (t, handler: keydownEvent => unit) => {
  t->on(#keydown, dangerousToEventHandler(handler))
}
