open ReactNative
open Style

@react.component
let make = (~navigation as _, ~route as _) => {
  <LVScreen>
    <LVHeader title="SETUP" />
    <View style={style(~flex=1.0, ~alignItems=#center, ~justifyContent=#center, ())}>
      <Text> {React.string("SETUP")} </Text>
    </View>
  </LVScreen>
}
