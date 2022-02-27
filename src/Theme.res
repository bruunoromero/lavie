let paperTheme = {
  ...ReactNativePaper.defaultTheme,
  roundness: 8.0,
  colors: {
    ...ReactNativePaper.defaultTheme.colors,
    accent: ReactNativePaper.defaultTheme.colors.primary,
  },
}

type sizing = {
  xs: float,
  sm: float,
  md: float,
  lg: float,
  xl: float,
}

type colors = {
  muted: string,
  primary: string,
  surface: string,
  background: string,
  waterBlue: string,
}

type theme = {
  colors: colors,
  elevation: float,
  spacing: sizing,
  roundness: float,
}

let theme = {
  colors: {
    muted: "#CFD8DC",
    waterBlue: "#0e87cc",
    primary: paperTheme.colors.primary,
    surface: paperTheme.colors.surface,
    background: paperTheme.colors.background,
  },
  spacing: {
    xs: 8.0,
    sm: 12.0,
    md: 16.0,
    lg: 20.0,
    xl: 24.0,
  },
  elevation: 2.0,
  roundness: paperTheme.roundness,
}

let themeContext = React.createContext(theme)

let use = () => React.useContext(themeContext)

let makeStyles = (builder: theme => Js.t<'a>, ()) => {
  let theme = use()

  React.useMemo2(() => builder(theme), (theme, builder))
}

module Provider = {
  let provider = React.Context.provider(themeContext)

  @react.component
  let make = (~children, ~theme) => {
    React.createElement(provider, {"value": theme, "children": children})
  }
}
