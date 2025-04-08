let useLog = msg => {
  React.useEffect(() => {
    Console.log(msg)
    None
  }, [msg])
}
