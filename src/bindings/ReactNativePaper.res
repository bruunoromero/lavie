open ReactNative

type animation = {scale: float}

type colors = {
  primary: string,
  accent: string,
  background: string,
  surface: string,
  error: string,
  text: string,
  onSurface: string,
  disabled: string,
  placeholder: string,
  backdrop: string,
  notification: string,
}

type fonts

type theme = {
  dark: bool,
  roundness: float,
  colors: colors,
  animation: animation,
  fonts: fonts,
}

@module("react-native-paper") external defaultTheme: theme = "DefaultTheme"
@module("react-native-paper") external useTheme: unit => theme = "useTheme"

module Appbar = {
  module Header = {
    @module("./ReactNativePaper.ts") @react.component
    external make: (~children: React.element, ~style: Style.t=?) => React.element = "AppbarHeader"
  }

  module Content = {
    @module("./ReactNativePaper.ts") @react.component
    external make: (~title: string) => React.element = "AppbarContent"
  }

  module BackAction = {
    @module("./ReactNativePaper.ts") @react.component
    external make: (~onPress: unit => unit=?) => React.element = "AppbarBackAction"
  }
}

module Avatar = {
  module Text = {
    @module("./ReactNativePaper.ts") @react.component
    external make: (~label: string, ~size: float=?) => React.element = "AvatarText"
  }
}

module IconButton = {
  @module("react-native-paper") @react.component
  external make: (
    ~icon: string,
    ~color: string=?,
    ~onPress: ReactNative.Event.pressEvent => unit,
  ) => React.element = "IconButton"
}

module Fab = {
  @module("react-native-paper") @react.component
  external make: (
    ~icon: string,
    ~small: bool=?,
    ~color: string=?,
    ~style: Style.t=?,
    ~disabled: bool=?,
    ~onPress: ReactNative.Event.pressEvent => unit,
  ) => React.element = "FAB"
}

module Button = {
  @module("react-native-paper") @react.component
  external make: (
    ~icon: string=?,
    ~compact: bool=?,
    ~style: Style.t=?,
    ~disabled: bool=?,
    ~testID: string=?,
    ~uppercase: bool=?,
    ~labelStyle: Style.t=?,
    ~children: React.element,
    ~mode: [#text | #outlined | #contained]=?,
    ~onPress: ReactNative.Event.pressEvent => unit,
  ) => React.element = "Button"
}

module Surface = {
  @module("react-native-paper") @react.component
  external make: (~children: React.element, ~style: Style.t=?) => React.element = "Surface"
}

module ProgressBar = {
  @module("react-native-paper") @react.component
  external make: (
    ~color: string=?,
    ~progress: float,
    ~style: Style.t=?,
    ~testID: string=?,
  ) => React.element = "ProgressBar"
}

module Provider = {
  @module("react-native-paper") @react.component
  external make: (~children: React.element, ~theme: theme=?) => React.element = "Provider"
}
