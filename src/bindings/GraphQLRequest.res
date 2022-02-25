type client

@deriving(abstract)
type requestOpts<'a, 'b> = {
  document: string,
  @optional url: string,
  @optional variables: 'a,
  @optional requestHeaders: Js.t<'b>,
}

@module("graphql-request") @new
external makeClient: string => client = "GraphQLClient"

@send
external request: (client, requestOpts<'a, 'b>) => 'c = "request"
