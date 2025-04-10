type document
type node
type classList

@val external document: document = "document"
@send external querySelector: (document, string) => option<node> = "querySelector"
@send external createElement: (document, [#div | #span | #p]) => node = "createElement"

@send external appendChild: (node, node) => unit = "appendChild"
@send external insertBefore: (node, node, ~reference: node) => unit = "insertBefore"

@get external classList: node => classList = "classList"
@send @variadic external addClass: (classList, array<string>) => unit = "add"
@send @variadic external removeClass: (classList, array<string>) => unit = "remove"
@send external toggleClass: (classList, string, bool) => unit = "toggle"

@set external textContent: (node, string) => unit = "textContent"
