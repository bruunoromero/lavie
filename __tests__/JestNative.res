@send external toBeEmpty: Jest.expect => unit = "toBeEmpty"
@send external toBeEnabled: Jest.expect => unit = "toBeEnabled"
@send external toBeDisabled: Jest.expect => unit = "toBeDisabled"

@send
external toHaveTextContent: (Jest.expect, @unwrap [#Str(string) | #RegExp(Js.Re.t)]) => unit =
  "toHaveTextContent"

@send
external _toContainElement: (
  Jest.expect,
  Js.null_undefined<ReactNativeTestingLibrary.reactTestInstance>,
) => unit = "toContainElement"

let toContainElement = (expect, testInstance) =>
  _toContainElement(expect, Js.Null_undefined.fromOption(testInstance))
