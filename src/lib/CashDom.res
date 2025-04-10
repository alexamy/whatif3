type t

@module("cash-dom")
external createElement: @string [@as("<div>") #div] => t = "$"

@send external dom: t => Dom.element = "get"
@send external addClass: (t, string) => t = "addClass"
@send external removeClass: (t, string) => t = "removeClass"
@send external hide: t => t = "hide"
@send external show: t => t = "show"
@send external append: (t, t) => t = "append"

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
