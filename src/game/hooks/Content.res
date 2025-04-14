let screens: array<Path.screen> = [
  {
    place: Table,
    computer: Watch,
    description: "Вы стоите у стола. На столе в беспорядке лежат заметки, ручки, бумажки и прочие предметы.",
    options: [("Вернуться", Center)],
  },
  {
    place: Window,
    computer: Watch,
    description: "Вы стоите у окна. За окном - улица, на которой виднеются машины и люди.",
    options: [("Вернуться", Center)],
  },
  {
    place: Door,
    computer: Door,
    description: "Вы стоите у двери. На двери надпись: \"Выход\", а также электронный код-замок. Дверь заперта.",
    options: [("Вернуться", Center)],
  },
]
