open ReactNative
open ReactNativeTypography

module LargeTitle = {
  @react.component
  let make = (~style=?, ~children: React.element) =>
    <Text style={Style.arrayOption([Some(Human.largeTitle), style])}> children </Text>
}

module Body = {
  @react.component
  let make = (~style=?, ~children: React.element) =>
    <Text style={Style.arrayOption([Some(Human.body), style])}> children </Text>
}
