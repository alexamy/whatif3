type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door | Watch

type screen = {
  place: place,
  computer: computer,
  description: string,
  options: array<(string, place)>,
}

let screens = [
  {
    place: Room,
    computer: Watch,
    description: "Вы стоите посреди комнаты.",
    options: [
      ("Подойти к столу", Table),
      ("Подойти к окну", Window),
      ("Подойти к двери", Door),
    ],
  },
  {
    place: Table,
    computer: Watch,
    description: "Вы стоите у стола.",
    options: [("Вернуться", Room)],
  },
  {
    place: Window,
    computer: Watch,
    description: "Вы стоите у окна.",
    options: [("Вернуться", Room)],
  },
  {
    place: Door,
    computer: Door,
    description: "Вы стоите у двери.",
    options: [("Вернуться", Room)],
  },
]
