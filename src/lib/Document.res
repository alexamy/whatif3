type document

@val external doc: document = "document"
@send external querySelector: (document, string) => option<Dom.element> = "querySelector"
