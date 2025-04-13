let x1 = <div />

let x2 =
  <div class="test">
    <div />
  </div>

let x3 =
  <div>
    <div />
    <div />
  </div>

module Link = {
  @jsx.component
  let make = (~count) => {
    <div />
  }
}

let x4 = <Link count=10 />
