type t

@module("dayjs")
external make: unit => t = "default"

@module("dayjs")
external fromDate: Js.Date.t => t = "default"

@send
external toDate: t => Js.Date.t = "toDate"

@send
external startOf: (t, string) => t = "startOf"

@send
external add: (t, int, string) => t = "add"

@send
external toISOString: t => string = "toISOString"
