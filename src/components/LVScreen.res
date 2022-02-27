open ReactNative
open Style

let useStyles = Theme.makeStyles(({colors}) =>
  {
    "container": viewStyle(~flex=1.0, ~backgroundColor=colors.background, ()),
  }
)

@react.component
let make = (~children: React.element) => {
  let styles = useStyles()

  <View style={styles["container"]}> children </View>
}
