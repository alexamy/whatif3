let render = () => {
  Jq.tree(#div, ~class="flex gap-4 justify-center", [Screen.Room.render(), Terminal.render()])
}
