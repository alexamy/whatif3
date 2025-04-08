type place =
  | Room
  | Table
  | Window
  | Door

type computer = Door

type screen = {
  place: place,
  computer: option<computer>,
  description: string,
  options: array<(string, place)>,
}

let screens = [
  {
    place: Room,
    computer: None,
    description: "Вы стоите посреди комнаты.",
    options: [
      ("Подойти к столу", Table),
      ("Подойти к окну", Window),
      ("Подойти к двери", Door),
    ],
  },
  {
    place: Table,
    computer: None,
    description: "Вы стоите у стола.",
    options: [("Вернуться", Room)],
  },
  {
    place: Window,
    computer: None,
    description: "Вы стоите у окна.",
    options: [("Вернуться", Room)],
  },
  {
    place: Door,
    computer: Some(Door),
    description: "Вы стоите у двери.",
    options: [("Вернуться", Room)],
  },
]
