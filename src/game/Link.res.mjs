// Generated by ReScript, PLEASE EDIT WITH CARE

import * as JsxRuntime from "react/jsx-runtime";

function Link(props) {
  var onClick = props.onClick;
  return JsxRuntime.jsx("a", {
              children: props.children,
              className: "not-prose  text-blue-300 hover:text-blue-400 visited:text-base",
              href: "#",
              onClick: (function (param) {
                  onClick();
                })
            });
}

var make = Link;

export {
  make ,
}
/* react/jsx-runtime Not a pure module */
