type renderResult
type queries

type reactTestInstance
type reactTestRendererJSON

type wrapper = {"children": React.element} => React.element

type renderOptions = {"wrapper": Js.undefined<wrapper>}

@module("@testing-library/react-native")
external _render: (React.element, renderOptions) => renderResult = "render"

let render = (~wrapper=?, component) =>
  _render(component, {"wrapper": Js.Undefined.fromOption(wrapper)})

@send
external update: (renderResult, React.element) => unit = "update"

@send
external rerender: (renderResult, React.element) => unit = "rerender"

@send
external toJSON: renderResult => Js.null_undefined<reactTestInstance> = "toJSON"

@send
external getByText: (renderResult, @unwrap [#Str(string) | #RegExp(Js.Re.t)]) => reactTestInstance =
  "getByText"

@send
external getByTestId: (
  renderResult,
  @unwrap [#Str(string) | #RegExp(Js.Re.t)],
) => reactTestInstance = "getByTestId"

module FireEvent = {
  type t

  @module("@testing-library/react-native")
  external fireEvent: t = "fireEvent"

  @send
  external _press: (t, reactTestInstance) => unit = "press"

  let press = _press(fireEvent)
}
