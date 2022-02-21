module AppHeader = Header

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
  include Stack.Make({
    type params = unit
  })

  @react.component
  let make = () => {
    <Navigator screenOptions={_ => options(~header=Header.render(_ => <AppHeader />), ())}>
      <Screen name="Home" component=HomeScreen.make />
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
