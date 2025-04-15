let useLog = msg => {
  React.useEffect(() => {
    Console.log(msg)
    None
  }, [msg])
}

let strings = strings => {
  strings->Array.join(" ")->React.string
}
