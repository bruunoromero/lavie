open Utils

@deriving({abstract: light})
type t = {
  id: string,
  userId: string,
  username: string,
  hydrationGoal: int,
}

module Logic = {
  let initials = profile => {
    switch profile->username->Strings.split(' ') {
    | [firstName, lastName] => Strings.first(firstName) ++ Strings.first(lastName)
    | [firstName] => Strings.first(firstName)
    | _ => ""
    }
  }
}
