module Auth = {
  type user = {id: string}
  type state = {user: option<user>}

  type action = LoggedIn(user) | LoggedOut

  let initialState = {user: None}

  let reducer = (_, action) => {
    switch action {
    | LoggedIn(user) => {user: Some(user)}
    | LoggedOut => {user: None}
    }
  }

  let mapUser = user => {id: Firebase.User.uid(user)}
}

type t = {auth: Auth.state}

type action = Auth(Auth.action)

let reducer = (state, action) =>
  switch action {
  | Auth(authAction) => {auth: Auth.reducer(state.auth, authAction)}
  }

@private let initialState = {auth: Auth.initialState}
@private let context = React.createContext((initialState, _ => ()))

let useGlobalState = () => React.useContext(context)
let useAuthState = () => {
  let ({auth}, dispatch) = useGlobalState()

  let authDispatch = React.useCallback1(action => dispatch(Auth(action)), [dispatch])

  (auth, authDispatch)
}

module Provider = {
  let provider = React.Context.provider(context)

  @react.component
  let make = (~children) => {
    let (state, dispatch) = React.useReducer(reducer, initialState)

    React.createElement(provider, {"value": (state, dispatch), "children": children})
  }
}
