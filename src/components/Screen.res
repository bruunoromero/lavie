open ReactNative
open Style
open ReactNativePaper

@react.component
let make = (~children: React.element) => {
  let {colors} = useTheme()

  <View style={viewStyle(~flex=1.0, ~backgroundColor=colors.background, ())}> children </View>
}
