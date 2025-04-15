@module("mobx")
external observable: 'a => 'a = "observable"

@module("mobx-react-lite")
/** You do not need to use this function, it is automatically added by babel-mobx-observer script. */
external observer: React.component<'a> => React.component<'a> = "observer"

@module("mobx")
external action: (unit => unit) => unit => unit = "action"

@module("mobx")
external action1: ('a => unit) => 'a => unit = "action"

@module("mobx")
external action2: (('a, 'b) => unit) => ('a, 'b) => unit = "action"

@module("mobx")
external action3: (('a, 'b, 'c) => unit) => ('a, 'b, 'c) => unit = "action"
