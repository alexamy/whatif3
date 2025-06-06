// Generated by ReScript, PLEASE EDIT WITH CARE

import * as RoomDoor from "./RoomDoor.res.mjs";
import * as TerminalBase from "./TerminalBase.res.mjs";

var header = "Введите пароль для открытия двери";

var styleClass = "bg-red-400";

function processMessage(param) {
  var display = param.display;
  if (param.text !== "1234") {
    return display.screen({
                TAG: "Echo",
                _0: ["Неверный пароль"]
              });
  }
  display.screen({
        TAG: "Echo",
        _0: ["Дверь открыта"]
      });
  RoomDoor.addOpenDoorTransition();
}

var make = TerminalBase.makeComponent({
      header: header,
      styleClass: styleClass,
      knownCommands: undefined,
      processMessage: processMessage
    });

make.displayName = "RoomDoorTerminal";

var knownCommands;

export {
  header ,
  styleClass ,
  knownCommands ,
  processMessage ,
  make ,
}
/* make Not a pure module */
