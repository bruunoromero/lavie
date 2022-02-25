@deriving({abstract: light})
type t = {
  id: string,
  amount: int,
  userId: string,
}

module Logic = {
  let sumAmount = (hydration: array<t>) => Array.reduce(hydration, 0, (acc, el) => amount(el) + acc)
}
