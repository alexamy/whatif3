module Text = {
  @react.component
  let make = (~children: React.element) => {
    <article className="prose prose-slate dark:prose-invert"> {children} </article>
  }
}
