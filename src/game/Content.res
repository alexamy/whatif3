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
  options: array<string>,
}

let screens = [
  {
    place: Room,
    computer: None,
    description: "Вы стоите посреди комнаты.",
    options: [
      "Подойти к столу",
      "Подойти к окну",
      "Подойти к двери",
    ],
  },
  {
    place: Table,
    computer: None,
    description: "Вы стоите у стола.",
    options: ["Подойти к окну", "Подойти к двери"],
  },
  {
    place: Window,
    computer: None,
    description: "Вы стоите у окна.",
    options: ["Подойти к столу", "Подойти к двери"],
  },
  {
    place: Door,
    computer: Some(Door),
    description: "Вы стоите у двери.",
    options: ["Подойти к столу", "Подойти к окну"],
  },
]
