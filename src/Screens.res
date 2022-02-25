open ReactNavigation

module NotAuthed = {
  include NativeStack.Make({
    type params = unit
  })

  @react.component
  let make = () => {
    <Navigator screenOptions={_ => options(~headerShown=false, ())}>
      <Screen name="Login" component=LoginScreen.make />
    </Navigator>
  }
}

module Authed = {
  include Navigators.Authed

  @react.component
  let make = () => {
    <Navigator screenOptions={_ => options(~headerShown=false, ())}>
      <Group> <Screen name="Home" component=HomeScreen.make /> </Group>
      <Group screenOptions={_ => options(~presentation=#fullScreenModal, ())}>
        <Screen name="Profile" component=ProfileScreen.make />
        <Screen name="ProfileSetup" component=ProfileSetupScreen.make />
      </Group>
    </Navigator>
  }
}

module Root = {
  include NativeStack.Make({
    type params = unit
  })

  @react.component
  let make = () => {
    let (authState, _) = State.useAuthState()
    let isLoggedIn = Option.isSome(authState.user)

    <Native.NavigationContainer>
      {isLoggedIn ? <Authed /> : <NotAuthed />}
    </Native.NavigationContainer>
  }
}
