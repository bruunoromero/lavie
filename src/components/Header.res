open ReactNativePaper
open ReactNative
open Style
open Utils

@react.component
let make = (~title: string, ~left: option<React.element>=?, ~right: option<React.element>=?) => {
  let {colors} = useTheme()
  let {elevation} = Theme.useTheme()

  <Appbar.Header style={style(~backgroundColor=colors.surface, ~elevation, ())}>
    {unwrapComponent(left)} <Appbar.Content title /> {unwrapComponent(right)}
  </Appbar.Header>
}
