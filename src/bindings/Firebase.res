type app

module User = {
  type t

  @send
  external getIdToken: t => Promise.t<string> = "getIdToken"

  @get
  external uid: t => string = "uid"
}

module Auth = {
  type t
  type userCredential

  type subscription = unit => unit

  module Credential = {
    type t
  }

  module Provider = {
    type t

    @send
    external credential: (t, string) => Credential.t = "credential"
  }

  module GoogleProvider = {
    @module("firebase/auth")
    external _provider: Provider.t = "GoogleAuthProvider"

    let credential = Provider.credential(_provider)
  }

  @module("firebase/auth")
  external get: (~app: app=?) => t = "getAuth"

  @module("firebase/auth")
  external _onAuthStateChanged: (t, Js.null_undefined<User.t> => unit) => subscription =
    "onAuthStateChanged"

  @module("firebase/auth")
  external signOut: t => Promise.t<unit> = "signOut"

  @module("firebase/auth")
  external signInWithCredential: (t, Credential.t) => unit = "signInWithCredential"

  @get @return(nullable)
  external currentUser: t => option<User.t> = "currentUser"

  let onAuthStateChanged = (auth, cb) =>
    _onAuthStateChanged(auth, user => user->Js.Null_undefined.toOption->cb)
}

type config = {
  apiKey: string,
  authDomain: string,
  projectId: string,
  storageBucket: string,
  messagingSenderId: string,
  appId: string,
  measurementId: string,
}

@module("firebase/app")
external initializeApp: config => app = "initializeApp"
