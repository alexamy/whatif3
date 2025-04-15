@module("mobx")
external observable: 'a => 'a = "observable"

@module("mobx-react-lite")
/** You do not need to use this function, it is automatically added by babel-mobx-observer script. */
external observer: React.component<'a> => React.component<'a> = "observer"
