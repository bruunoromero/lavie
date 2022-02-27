type Route = {}

type Navigation = {
  push: jest.Mock<any, any>
}

export const makeNavigationMock = (): Navigation => {
  const push = jest.fn()

  return {
    push
  }
}

export const cleanupNavigationMock = (navigation: Navigation) => {
  navigation.push.mockClear()
}

export const makeRouteMock = (): Route => {
  return {}
}

export const cleanupRouteMock = (route: Route) => { }