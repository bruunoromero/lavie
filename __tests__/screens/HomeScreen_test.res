open Jest
open ReactNativeTestingLibrary
open TestHelper

let route = RouteMock.make()
let navigation = NavigationMock.make()

beforeEach(() => {
  RouteMock.cleanup(route)
  NavigationMock.cleanup(navigation)
})

describe("HomeScreen", () => {
  describe("Loaded", () => {
    open HomeScreen.Loaded

    describe("State", () => {
      open! State

      describe("reducer", () => {
        it("should increment glasses correctly", () => {
          let state = ref({
            glassesToAdd: -2,
            isAdding: false,
          })

          state := reducer(state.contents, IncrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: -1,
            isAdding: false,
          })

          state := reducer(state.contents, IncrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: 0,
            isAdding: false,
          })

          state := reducer(state.contents, IncrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: 1,
            isAdding: false,
          })
        })

        it("should decrement glasses correctly nad should not decrement beyond 1", () => {
          let state = ref({
            glassesToAdd: 3,
            isAdding: false,
          })

          state := reducer(state.contents, DecrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: 2,
            isAdding: false,
          })

          state := reducer(state.contents, DecrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: 1,
            isAdding: false,
          })

          state := reducer(state.contents, DecrementGlass)
          expect(state.contents)->toEqual({
            glassesToAdd: 1,
            isAdding: false,
          })
        })

        it("should set glassesToAdd to 1 and isAdding to true", () => {
          reducer({glassesToAdd: 3, isAdding: false}, StartAdding)
          ->expect
          ->toEqual({
            glassesToAdd: 1,
            isAdding: true,
          })

          reducer({glassesToAdd: -7, isAdding: false}, StartAdding)
          ->expect
          ->toEqual({
            glassesToAdd: 1,
            isAdding: true,
          })

          reducer({glassesToAdd: 1, isAdding: true}, StartAdding)
          ->expect
          ->toEqual({
            glassesToAdd: 1,
            isAdding: true,
          })
        })

        it("should set isAdding to false", () => {
          reducer({glassesToAdd: 3, isAdding: true}, AddCompleted)
          ->expect
          ->toEqual({
            glassesToAdd: 3,
            isAdding: false,
          })

          reducer({glassesToAdd: -7, isAdding: true}, AddCompleted)
          ->expect
          ->toEqual({
            glassesToAdd: -7,
            isAdding: false,
          })

          reducer({glassesToAdd: 1, isAdding: false}, AddCompleted)
          ->expect
          ->toEqual({
            glassesToAdd: 1,
            isAdding: false,
          })
        })
      })

      describe("canDecrementGlass", () => {
        it("should return true if glasses is higher than 1", () => {
          expect(canDecrementGlass({glassesToAdd: 2, isAdding: false}))->toBe(true)
          expect(canDecrementGlass({glassesToAdd: 2, isAdding: true}))->toBe(true)
          expect(canDecrementGlass({glassesToAdd: 3, isAdding: false}))->toBe(true)
          expect(canDecrementGlass({glassesToAdd: 4, isAdding: false}))->toBe(true)
          expect(canDecrementGlass({glassesToAdd: 1000, isAdding: false}))->toBe(true)
        })

        it("should return true if glasses is 1 or below", () => {
          expect(canDecrementGlass({glassesToAdd: 1, isAdding: false}))->toBe(false)
          expect(canDecrementGlass({glassesToAdd: 1, isAdding: true}))->toBe(false)
          expect(canDecrementGlass({glassesToAdd: -1, isAdding: false}))->toBe(false)
          expect(canDecrementGlass({glassesToAdd: 0, isAdding: false}))->toBe(false)
          expect(canDecrementGlass({glassesToAdd: -1000, isAdding: false}))->toBe(false)
        })
      })
    })

    describe("Logic", () => {
      open! Logic

      describe("amountToStr", () => {
        it("should return with ml when amount is less then 1000", () => {
          expect(amountToStr(0))->toBe("0ml")
          expect(amountToStr(100))->toBe("100ml")
          expect(amountToStr(999))->toBe("999ml")
        })

        it("should return with ml when amount is higher then 1000", () => {
          expect(amountToStr(1000))->toBe("1L")
          expect(amountToStr(4000))->toBe("4L")
          expect(amountToStr(1500))->toBe("1.5L")
        })
      })

      describe("glassesToAmount", () => {
        it("should take a number of glasses and multiply by the factor (200)", () => {
          expect(glassesToAmount(1))->toBe(200)
          expect(glassesToAmount(2))->toBe(400)
          expect(glassesToAmount(10))->toBe(2000)
          expect(glassesToAmount(-5))->toBe(-1000)
        })
      })

      describe("drinkPercentage", () => {
        it(
          "should take a goal and an amount of drunk and returns the percentage of the goal",
          () => {
            expect(drinkPercentage(100, 1))->toBe(0.01)
            expect(drinkPercentage(100, 100))->toBe(1.0)
            expect(drinkPercentage(100, 200))->toBe(2.0)
            expect(drinkPercentage(200, 134))->toBe(0.67)
          },
        )
      })

      describe("insightByRate", () => {
        it("should take a rate of drunk and returns insight", () => {
          expect(insightByRate(200.0))->toBe("completed")
          expect(insightByRate(100.0))->toBe("completed")
          expect(insightByRate(67.0))->toBe("almost there")
          expect(insightByRate(34.0))->toBe("you can do better")
          expect(insightByRate(1.0))->toBe("poor hydration")
        })
      })
    })

    describe("Progress", () => {
      it("should render without crashing", () => {
        render(<HomeScreen.Loaded.Progress percentage={0.5} />)->toJSON->expect->toMatchSnapshot
      })
    })

    describe("BottomSheet", () => {
      it("should render without crashing", () => {
        let onAdd = fn(ignore)
        let onIncrement = fn(ignore)
        let onDecrement = fn(ignore)
        let state: State.t = {glassesToAdd: 1, isAdding: false}

        render(<HomeScreen.Loaded.BottomSheet state onAdd onIncrement onDecrement />)
        ->toJSON
        ->expect
        ->toMatchSnapshot
      })
    })

    it("should render without crashing", () => {
      let profile = Profile.t(
        ~id="1234",
        ~username="Bruno Romero",
        ~userId="1234",
        ~hydrationGoal=2000,
      )

      let hydration = [
        Hydration.t(~id="123", ~amount=200, ~userId="123"),
        Hydration.t(~id="123", ~amount=200, ~userId="123"),
      ]

      render(<HomeScreen.Loaded navigation profile hydration />)->toJSON->expect->toMatchSnapshot
    })
  })

  it("should render without crashing", () => {
    render(<HomeScreen navigation route />)->toJSON->expect->toMatchSnapshot
  })
})
