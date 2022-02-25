open ReactNavigation

module Authed = {
  include NativeStack.Make({
    type params = unit
  })
}

module Main = {
  include NativeStack.Make({
    type params = unit
  })
}
