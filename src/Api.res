open Promise

let url = "http://localhost:4000/api/graphql"

let client = GraphQLRequest.makeClient(url)

module type Operation = {
  module Raw: {
    type t
    type t_variables
  }
  type t
  type t_variables

  let query: string
  let parse: Raw.t => t
  let serializeVariables: t_variables => Raw.t_variables
  let variablesToJson: Raw.t_variables => Js.Json.t
}

let request:
  type variables variablesJs data response. (
    ~query: module(Operation with
      type t_variables = variables
      and type Raw.t_variables = variablesJs
      and type t = data
    ),
    variables,
  ) => Promise.t<response> =
  (~query as module(Query), variables) => {
    let document = Query.query

    let variables = variables->Query.serializeVariables->Query.variablesToJson

    let opts = switch Firebase.Auth.currentUser(Service.auth) {
    | Some(user) =>
      Firebase.User.getIdToken(user)->thenResolve(token => {
        GraphQLRequest.requestOpts(
          ~variables,
          ~document,
          ~requestHeaders={"Authorization": `Bearer ${token}`},
          (),
        )
      })
    | None => resolve(GraphQLRequest.requestOpts(~document, ()))
    }

    opts->then(opts => GraphQLRequest.request(client, opts))
  }

type response<'a> =
  | Loading
  | Loaded('a)
  | Error

let mapResponse = (response, mapper) => {
  switch response {
  | Loading => Loading
  | Error => Error
  | Loaded(data) => Loaded(mapper(data))
  }
}

let toOption = resp =>
  switch resp {
  | Loaded(data) => Some(data)
  | _ => None
  }

let concat2 = (first, second) =>
  switch (first, second) {
  | (Error, _)
  | (_, Error) =>
    Error
  | (Loaded(a), Loaded(b)) => Loaded((a, b))
  | _ => Loading
  }

let useRequest:
  type variables variablesJs data r. (
    ~query: module(Operation with
      type t_variables = variables
      and type Raw.t_variables = variablesJs
      and type t = data
    ),
    variables,
  ) => response<r> =
  (~query as module(Query), variables) => {
    let document = Query.query

    let response = ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=_ => request(~query=module(Query), variables),
        ~queryKey=document,
        (),
      ),
    )

    switch response {
    | {isLoading: true} => Loading
    | {data: Some(data), isLoading: false, isError: false} => Loaded(data)
    | _ => Error
    }
  }

module Profile = {
  let use = () => Loaded(
    Profile.t(~id="123", ~userId="123", ~hydrationGoal=2000, ~username="Bruno Romero"),
  )

  let useGetProfile = () => Loaded(
    Some(Profile.t(~id="123", ~userId="123", ~hydrationGoal=2000, ~username="Marya Clara")),
  )
}

module Hydration = {
  let use = () => Loaded([
    Hydration.t(~id="123", ~amount=200, ~userId="123"),
    Hydration.t(~id="123", ~amount=200, ~userId="123"),
  ])
}
