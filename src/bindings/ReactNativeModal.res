open ReactNative

@module("react-native-modal") @react.component
external make: (
  ~children: React.element,
  ~isVisible: bool=?,
  ~style: Style.t=?,
  ~hasBackdrop: bool=?,
) => React.element = "default"
