type place =
  | Room
  | Table
  | Window
  | Door

type screen = {
  place: place,
  description: string,
  options: array<string>,
}

let screens = [
  {
    place: Room,
    description: "Вы стоите посреди комнаты.",
    options: [
      "Подойти к столу",
      "Подойти к окну",
      "Подойти к двери",
    ],
  },
  {
    place: Table,
    description: "Вы стоите у стола.",
    options: ["Подойти к окну", "Подойти к двери"],
  },
  {
    place: Window,
    description: "Вы стоите у окна.",
    options: ["Подойти к столу", "Подойти к двери"],
  },
  {
    place: Door,
    description: "Вы стоите у двери.",
    options: ["Подойти к столу", "Подойти к окну"],
  },
]
