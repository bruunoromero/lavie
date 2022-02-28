open ReactNative
open Style

open! ReactNativePaper

let useStyles = Theme.makeStyles(_ =>
  {
    "main": viewStyle(~elevation=0.0, ~padding=2.5->dp, ()),
    "label": textStyle(~textTransform=#capitalize, ~fontSize=16.0, ()),
  }
)

@react.component
let make = (
  ~icon=?,
  ~mode=?,
  ~style=?,
  ~testID=?,
  ~compact=?,
  ~disabled=?,
  ~uppercase=?,
  ~labelStyle=?,
  ~onPress,
  ~children,
) => {
  let styles = useStyles()

  <Button
    ?testID
    ?icon
    ?disabled
    ?compact
    onPress
    mode={Option.getWithDefault(mode, #contained)}
    uppercase={Option.getWithDefault(uppercase, false)}
    style={Style.arrayOption([Some(styles["main"]), style])}
    labelStyle={Style.arrayOption([Some(styles["label"]), labelStyle])}>
    children
  </Button>
}
