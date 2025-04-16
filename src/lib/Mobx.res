@module("mobx-react-lite")
external observer: React.component<'a> => React.component<'a> = "observer"

@module("mobx")
external observable: 'a => 'a = "observable"

@module("mobx")
external autorun: (unit => unit) => unit = "autorun"

@module("mobx")
external action: (unit => unit) => unit => unit = "action"

@module("mobx")
external action1: ('a => unit) => 'a => unit = "action"

@module("mobx")
external action2: (('a, 'b) => unit) => ('a, 'b) => unit = "action"

@module("mobx")
external action3: (('a, 'b, 'c) => unit) => ('a, 'b, 'c) => unit = "action"

@module("mobx")
external toJS: 'a => 'a = "toJS"
