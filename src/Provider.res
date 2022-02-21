module Auth = {
  @react.component
  let make = (~children: React.element) => {
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

@react.component
let make = (~children) => {
  <State.Provider> <Auth> children </Auth> </State.Provider>
}
