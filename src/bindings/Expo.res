module AuthSession = {
  module Providers = {
    module Google = {
      type request
      type responseParams = {id_token: string}
      type response = {@as("type") type_: [#success], params: responseParams}
      type idTokenAuthRequestOpts = {clientId: string}

      @module("expo-auth-session/providers/google")
      external _useIdTokenAuthRequest: idTokenAuthRequestOpts => (
        Js.null_undefined<request>,
        Js.null_undefined<response>,
        unit => unit,
      ) = "useIdTokenAuthRequest"

      let useIdTokenAuthRequest = idTokenAuthRequestOpts => {
        let (request, response, promptAsync) = _useIdTokenAuthRequest(idTokenAuthRequestOpts)

        (Js.Nullable.toOption(request), Js.Nullable.toOption(response), promptAsync)
      }
    }
  }
}

module WebBrowser = {
  @module("expo-web-browser")
  external maybeCompleteAuthSession: unit => unit = "maybeCompleteAuthSession"
}
