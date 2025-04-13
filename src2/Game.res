@jsx.component
let make = () => {
  <div class="w-full h-full min-h-screen m-0 p-6 bg-gray-900 text-gray-100">
    <div class="mx-auto min-w-xl max-w-5xl">
      <div class="flex gap-4 justify-center">
        <Screen.Room />
        <Terminal />
      </div>
    </div>
  </div>
}
