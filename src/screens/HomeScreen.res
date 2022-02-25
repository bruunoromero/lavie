open ReactNative
open Style
open Navigators
open ReactNativePaper

open! ReactNativeSafeAreaContext
module Loaded = {
  module State = {
    type t = {glassesToAdd: int, isAdding: bool}

    type action =
      | IncrementGlass
      | DecrementGlass
      | StartAdding
      | AddCompleted

    let canDecrementGlass = state => state.glassesToAdd >= 1

    let reducer = (state, action) =>
      switch action {
      | StartAdding => {glassesToAdd: 1, isAdding: true}
      | AddCompleted => {...state, isAdding: false}
      | IncrementGlass => {...state, glassesToAdd: state.glassesToAdd + 1}
      | DecrementGlass =>
        if canDecrementGlass(state) {
          {...state, glassesToAdd: state.glassesToAdd - 1}
        } else {
          {...state, glassesToAdd: 1}
        }
      }

    let useState = () => React.useReducer(reducer, {glassesToAdd: 1, isAdding: false})
  }

  module Logic = {
    let amountToStr = amount => {
      if amount >= 1000 {
        `${Float.toString(Int.toFloat(amount) /. 1000.0)}L`
      } else {
        `${Int.toString(amount)}ml`
      }
    }
    let glassesToAmount = glasses => glasses * 200

    let drinkPercentage = (goal, drunk) => Int.toFloat(drunk) /. Int.toFloat(goal) *. 100.0

    let toInsight = (goal, drunk) => {
      let drunkPercentage = drinkPercentage(goal, drunk)

      if drunkPercentage >= 100.0 {
        "completed"
      } else if drunkPercentage > 66.0 {
        "almost there"
      } else if drunkPercentage > 33.0 {
        "you can do better"
      } else {
        "poor hydration"
      }
    }
  }

  module BottomSheet = {
    @react.component
    let make = () => {
      let {colors, elevation} = Theme.useTheme()

      <Surface
        style={viewStyle(
          ~flex=1.0,
          ~elevation,
          ~borderTopLeftRadius=50.0,
          ~borderTopRightRadius=50.0,
          ~backgroundColor=colors.muted,
          (),
        )}>
        <SafeAreaView> <Text> {React.string("ola")} </Text> </SafeAreaView>
      </Surface>
    }
  }

  let styles = StyleSheet.create({
    "main": viewStyle(~flex=2.0, ()),
  })

  @react.component
  let make = (~navigation, ~profile, ~hydration as _) => {
    let (_state, _dispatch) = State.useState()

    <Screen>
      <Header
        title="Hydration"
        right={<Pressable onPress={_ => Authed.Navigation.navigate(navigation, "Profile")}>
          {_ => <Avatar.Text label={Profile.Logic.initials(profile)} size={42.0} />}
        </Pressable>}
      />
      <View style={styles["main"]}>
        <Text> {React.string("Today you took 0ml of water")} <Emoji.Drop /> </Text>
      </View>
      <BottomSheet />
    </Screen>
  }
}

@react.component
let make = (~navigation, ~route as _) => {
  let profile = Api.Profile.useProfile()
  let hydration = Api.Hydration.useHydration()

  switch Api.concat2(profile, hydration) {
  | Api.Loaded((profile, hydration)) => <Loaded navigation profile hydration />
  | _ => <Text> {React.string("woops")} </Text>
  }
}
