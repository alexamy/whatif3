let useLog = msg => {
  React.useEffect(() => {
    Console.log(msg)
    None
  }, [msg])
}

let strings = strings => {
  strings->Array.joinWith(" ", x => x)->React.string
}
