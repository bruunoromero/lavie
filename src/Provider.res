module Auth = {
  @react.component
  let make = (~children) => {
    let (_, dispatch) = State.useAuthState()
    let (isInitialized, setInitialized) = React.useState(() => false)

    React.useEffect2(() => {
      let unsubscribre = Firebase.Auth.onAuthStateChanged(Service.auth, user => {
        switch user {
        | Some(user) => user->State.Auth.mapUser->State.Auth.LoggedIn->dispatch
        | None => dispatch(State.Auth.LoggedOut)
        }
        setInitialized(_ => true)
      })

      Some(() => unsubscribre())
    }, (dispatch, setInitialized))

    if isInitialized {
      children
    } else {
      React.null
    }
  }
}

module Query = {
  let client = ReactQuery.Provider.createClient()

  @react.component
  let make = (~children) => {
    <ReactQuery.Provider client> children </ReactQuery.Provider>
  }
}

module Onboarding = {
  @react.component
  let make = (~children) => {
    let profile = Api.Profile.useGetProfile()
    let (shouldOnboard, setShouldOnboard) = React.useState(() => false)

    React.useEffect2(() => {
      switch profile {
      | Api.Loaded(data) =>
        switch data {
        | None => setShouldOnboard(_ => true)
        | _ => setShouldOnboard(_ => false)
        }
      | _ => setShouldOnboard(_ => false)
      }

      None
    }, (profile, setShouldOnboard))

    <> children <OnboardingScreen isOpen={shouldOnboard} /> </>
  }
}

@react.component
let make = (~children) => {
  open ReactNativeSafeAreaContext

  <SafeAreaProvider>
    <Query>
      <ReactNativePaper.Provider theme={Theme.paperTheme}>
        <Theme.Provider theme={Theme.theme}>
          <State.Provider> <Auth> <Onboarding> children </Onboarding> </Auth> </State.Provider>
        </Theme.Provider>
      </ReactNativePaper.Provider>
    </Query>
  </SafeAreaProvider>
}
