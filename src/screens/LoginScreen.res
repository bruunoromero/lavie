open ReactNative
open Style

@react.component
let make = (~navigation as _, ~route as _) => {
  let (request, response, promptAsync) = Expo.AuthSession.Providers.Google.useIdTokenAuthRequest({
    clientId: Config.googleWebClientId,
  })

  React.useEffect1(() => {
    switch response {
    | Some(response) =>
      if response.type_ === #success {
        let id_token = response.params.id_token
        let creds = Firebase.Auth.GoogleProvider.credential(id_token)
        Firebase.Auth.signInWithCredential(Service.auth, creds)
      }
    | None => ()
    }
    None
  }, [response])

  <Screen>
    <Header title="Home" />
    <View
      style={style(
        ~flex=1.0,
        ~alignItems=#center,
        ~backgroundColor="#fff",
        ~justifyContent=#center,
        (),
      )}>
      <Button
        disabled={Option.isNone(request)}
        title="Login"
        onPress={_ => {
          promptAsync()
        }}
      />
    </View>
  </Screen>
}
