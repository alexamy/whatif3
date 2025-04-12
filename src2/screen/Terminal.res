let render = () => {
  Jq.tree(
    #div,
    ~class="monospace screen-w screen-h outline-0 whitespace-pre text-nowrap text-gray-800 p-2 flex flex-col justify-between",
    ~classes=Js.Dict.fromArray([("bg-blue-400", true)]),
    [Jq.strings(["Компьютер"])],
  )
}
