open ReactNative
open Style
open ReactNativePaper
open Navigators.Authed.Navigation

@react.component
let make = (~navigation, ~route as _) => {
  <LVScreen>
    <LVHeader
      left={<Appbar.BackAction onPress={() => goBack(navigation, ())} />} title="Profile!!!"
    />
    <View style={style(~flex=1.0, ~alignItems=#center, ~justifyContent=#center, ())}>
      <Text> {React.string("Profile")} </Text>
    </View>
  </LVScreen>
}
