let paperTheme = ReactNativePaper.defaultTheme

type colors = {primary: string, muted: string}

type theme = {colors: colors, elevation: float}

let theme = {
  colors: {
    primary: paperTheme.colors.primary,
    muted: "#CFD8DC",
  },
  elevation: 5.0,
}

let themeContext = React.createContext(theme)

let useTheme = () => React.useContext(themeContext)

module Provider = {
  let provider = React.Context.provider(themeContext)

  @react.component
  let make = (~children, ~theme) => {
    React.createElement(provider, {"value": theme, "children": children})
  }
}
