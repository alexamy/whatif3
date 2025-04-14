@module("mobx")
external observable: 'a => 'a = "observable"

@module("mobx-react-lite")
external observer: React.component<'a> => React.component<'a> = "observer"
