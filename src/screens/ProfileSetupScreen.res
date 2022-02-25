open ReactNative
open Style

@react.component
let make = (~navigation as _, ~route as _) => {
  <Screen>
    <Header title="SETUP" />
    <View
      style={style(
        ~flex=1.0,
        ~alignItems=#center,
        ~backgroundColor="#fff",
        ~justifyContent=#center,
        (),
      )}>
      <Text> {React.string("SETUP")} </Text>
    </View>
  </Screen>
}
