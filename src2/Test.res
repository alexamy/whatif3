let x1 = <div />

let x2 =
  <div class="test">
    <div />
  </dbind

let x3 =
  <div>
    <div />
    <div />
  </dbind

module Link = {
  @jsx.component
  let make = (~count) => {
    <div />
  }
}

module Nest = {
  @jsx.component
  let make = (~children) => {
    <div> {children} </dbind
  }
}

let x4 = <Link count=10 />

let x5 =
  <Nest>
    <Link count=10 />
  </Nest>

let x6 =
  <Nest>
    <Link count=10 />
    <Link count=20 />
  </Nest>

let x7 =
  <Nest>
    {<>
      <Link count=10 />
      <Link count=20 />
    </>}
  </Nest>

let x8 = <Nest> {<> </>} </Nest>
