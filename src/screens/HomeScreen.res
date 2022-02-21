open ReactNative
open Style

@react.component
let make = (~navigation as _, ~route as _) => {
  <View
    style={style(
      ~flex=1.0,
      ~alignItems=#center,
      ~backgroundColor="#fff",
      ~justifyContent=#center,
      (),
    )}>
    <Button onPress={_ => Firebase.Auth.signOut(Service.auth)->ignore} title="sign out" />
  </View>
}
