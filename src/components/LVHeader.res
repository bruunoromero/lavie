open ReactNativePaper
open ReactNative
open Style
open Utils

let useStyles = Theme.makeStyles(({colors, elevation}) =>
  {
    "container": viewStyle(~backgroundColor=colors.background, ~elevation, ()),
  }
)

@react.component
let make = (~title, ~left=?, ~right=?) => {
  let styles = useStyles()

  <Appbar.Header style={styles["container"]}>
    {unwrapComponent(left)} <Appbar.Content title /> {unwrapComponent(right)}
  </Appbar.Header>
}
