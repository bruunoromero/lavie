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
external toJSON: renderResult => Js.null_undefined<reactTestInstance> = "toJSON"

@send
external getByText: (renderResult, @unwrap [#Str(string) | #RegExp(Js.Re.t)]) => reactTestInstance =
  "getByText"

@send
external getByTestId: (
  renderResult,
  @unwrap [#Str(string) | #RegExp(Js.Re.t)],
) => reactTestInstance = "getByTestId"
