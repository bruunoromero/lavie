type Route = {}

type Navigation = {
  push: jest.Mock<any, any>
  navigate: jest.Mock<any, any>
}

export const makeNavigationMock = (): Navigation => {
  const push = jest.fn()
  const navigate = jest.fn()

  return {
    push,
    navigate
  }
}

export const cleanupNavigationMock = (navigation: Navigation) => {
  navigation.push.mockClear()
  navigation.navigate.mockClear()
}

export const makeRouteMock = (): Route => {
  return {}
}

export const cleanupRouteMock = (route: Route) => { }