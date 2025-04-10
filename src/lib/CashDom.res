type t

@module("cash-dom")
external createElement: @string [@as("<div>") #Div] => t = "$"

@send external addClass: (t, string) => t = "addClass"
@send external removeClass: (t, string) => t = "removeClass"
@send external hide: t => t = "hide"
@send external show: t => t = "show"
