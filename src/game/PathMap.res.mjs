// Generated by ReScript, PLEASE EDIT WITH CARE

import * as RoomDoor from "./RoomDoor.res.mjs";
import * as RoomTable from "./RoomTable.res.mjs";
import * as RoomCenter from "./RoomCenter.res.mjs";
import * as Caml_exceptions from "rescript/lib/es6/caml_exceptions.js";
import * as RoomDoorTerminal from "./RoomDoorTerminal.res.mjs";
import * as TerminalHandwatch from "./TerminalHandwatch.res.mjs";

var NotFound = /* @__PURE__ */Caml_exceptions.create("PathMap.NotFound");

var map = new Map([
      [
        "RoomCenter",
        {
          left: RoomCenter.make,
          right: TerminalHandwatch.make
        }
      ],
      [
        "RoomTable",
        {
          left: RoomTable.make,
          right: TerminalHandwatch.make
        }
      ],
      [
        "RoomDoor",
        {
          left: RoomDoor.make,
          right: RoomDoorTerminal.make
        }
      ]
    ]);

function get(current) {
  var info = map.get(current);
  if (info !== undefined) {
    return info;
  }
  throw {
        RE_EXN_ID: NotFound,
        _1: current,
        Error: new Error()
      };
}

export {
  NotFound ,
  map ,
  get ,
}
/* map Not a pure module */
