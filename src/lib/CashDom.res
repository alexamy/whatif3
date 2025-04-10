type t

@module("cash-dom")
external createElement: @string [@as("<div>") #Div] => t = "$"

@send external dom: t => Dom.element = "get"
@send external addClass: (t, string) => t = "addClass"
@send external removeClass: (t, string) => t = "removeClass"
@send external hide: t => t = "hide"
@send external show: t => t = "show"
@send external append: (t, t) => t = "append"
@send external on: (t, @string [@as("click") #Click]) => t = "on"
