module NavigationMock = {
  open ReactNavigation

  @module("./TestHelper.ts")
  external make: unit => Core.navigation = "makeNavigationMock"

  @module("./TestHelper.ts")
  external cleanup: Core.navigation => unit = "cleanupNavigationMock"
}

module RouteMock = {
  open ReactNavigation

  @module("./TestHelper.ts")
  external make: unit => Core.route<'a> = "makeRouteMock"

  @module("./TestHelper.ts")
  external cleanup: Core.route<'a> => unit = "cleanupRouteMock"
}
