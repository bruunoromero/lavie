open ReactNative
open Style
open Navigators
open Expo.VectorIcons
open Utils

open! ReactNativePaper
open! ReactNativeSafeAreaContext

module Loaded = {
  module State = {
    type t = {glassesToAdd: int, isAdding: bool}

    type action =
      | IncrementGlass
      | DecrementGlass
      | StartAdding
      | AddCompleted

    let canDecrementGlass = state => state.glassesToAdd > 1

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

    let use = () => React.useReducer(reducer, {glassesToAdd: 1, isAdding: false})
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

    let drinkPercentage = (goal, drunk) => Int.toFloat(drunk) /. Int.toFloat(goal)

    let insightByRate = rate => {
      if rate >= 100.0 {
        "completed"
      } else if rate > 66.0 {
        "almost there"
      } else if rate > 33.0 {
        "you can do better"
      } else {
        "poor hydration"
      }
    }
  }

  module Progress = {
    let useStyles = Theme.makeStyles(({colors, spacing}) =>
      {
        "label": textStyle(~textAlign=#center, ()),
        "insight": textStyle(~textAlign=#center, ()),
        "bar": viewStyle(~height=64.0->dp, ~borderRadius=36.0, ()),
        "textContainer": viewStyle(~paddingTop=spacing.md->dp, ()),
        "rate": textStyle(~color=colors.primary, ~fontWeight=#_700, ()),
      }
    )

    @react.component
    let make = (~percentage: float) => {
      let styles = useStyles()
      let {colors} = Theme.use()

      let rate = React.useMemo1(() => Floats.toRate(percentage), [percentage])

      <View>
        <ProgressBar progress={percentage} style={styles["bar"]} color={colors.waterBlue} />
        <View style={styles["textContainer"]}>
          <LVText.Body style={styles["insight"]}>
            {React.string(Logic.insightByRate(rate))}
          </LVText.Body>
        </View>
        <View style={styles["textContainer"]}>
          <LVText.Body style={styles["label"]}>
            <Text> {React.string("You've drunk ")} </Text>
            <Text testID="drunk-rate" style={styles["rate"]}>
              {React.string(`${Float.toString(rate)}%`)}
            </Text>
            <Text> {React.string(" of your goal")} </Text>
          </LVText.Body>
        </View>
      </View>
    }
  }

  module BottomSheet = {
    open State

    let useStyles = Theme.makeStyles(({colors, elevation, spacing, roundness}) =>
      {
        "container": viewStyle(
          ~flex=1.0,
          ~elevation,
          ~borderTopLeftRadius=50.0,
          ~borderTopRightRadius=50.0,
          ~backgroundColor=colors.muted,
          ~paddingHorizontal=spacing.xl->dp,
          (),
        ),
        "safeArea": viewStyle(~flex=1.0, ()),
        "mainContainer": viewStyle(~flex=2.0, ()),
        "buttonsContainer": viewStyle(
          ~flex=2.0,
          ~alignItems=#center,
          ~flexDirection=#row,
          ~justifyContent=#spaceAround,
          (),
        ),
        "iconContainer": viewStyle(
          ~elevation=0.0,
          ~padding=spacing.md->dp,
          ~borderRadius=roundness,
          (),
        ),
        "labelCount": textStyle(~fontWeight=#bold, ()),
        "footerContainer": viewStyle(~flex=1.0, ~justifyContent=#center, ()),
        "labelContainer": viewStyle(~flex=1.0, ~justifyContent=#center, ~alignItems=#center, ()),
      }
    )

    @react.component
    let make = (~onIncrement, ~onDecrement, ~onAdd, ~state) => {
      let styles = useStyles()
      let {colors} = Theme.use()

      let canDecrement = React.useMemo1(() => canDecrementGlass(state), [state])

      <Surface style={styles["container"]}>
        <SafeAreaView style={styles["safeArea"]}>
          <View style={styles["mainContainer"]}>
            <View style={styles["buttonsContainer"]}>
              <LVButton
                compact=true
                testID="decrement"
                disabled={!canDecrement}
                onPress={_ => onDecrement()}>
                <MaterialCommunityIcons name="minus" size={26.0} />
              </LVButton>
              <Surface style={styles["iconContainer"]}>
                <MaterialCommunityIcons name="cup-water" size={38.0} color={colors.waterBlue} />
              </Surface>
              <LVButton testID="increment" compact=true onPress={_ => onIncrement()}>
                <MaterialCommunityIcons name="plus" size={26.0} />
              </LVButton>
            </View>
            <View style={styles["labelContainer"]}>
              <LVText.Body>
                <Text testID="glass-count" style={styles["labelCount"]}>
                  {React.string(`${Int.toString(state.glassesToAdd)}x`)}
                </Text>
                <Text testID="glass-amount-count">
                  {React.string(
                    ` glasses (${Logic.glassesToAmount(state.glassesToAdd)->Logic.amountToStr})`,
                  )}
                </Text>
              </LVText.Body>
            </View>
          </View>
          <View style={styles["footerContainer"]}>
            <LVButton testID="add" icon="water" disabled={state.isAdding} onPress={_ => onAdd()}>
              {React.string("add drink")}
            </LVButton>
          </View>
        </SafeAreaView>
      </Surface>
    }
  }

  let useStyles = Theme.makeStyles(({colors, spacing}) =>
    {
      "mainContainer": viewStyle(~flex=3.0, ~paddingHorizontal=(spacing.lg *. 3.0)->dp, ()),
      "titleContainer": viewStyle(~paddingVertical=(spacing.lg *. 2.0)->dp, ()),
      "bottomSheet": viewStyle(~flex=2.0, ()),
      "amount": textStyle(~color=colors.primary, ~fontWeight=#_700, ()),
      "progressContainer": viewStyle(~flex=1.0, ~justifyContent=#center, ()),
      "title": textStyle(~textAlign=#center, ()),
    }
  )

  @react.component
  let make = (~navigation, ~profile, ~hydration) => {
    let styles = useStyles()
    let (state, dispatch) = State.use()

    let add = React.useCallback1(() => dispatch(StartAdding), [dispatch])
    let increment = React.useCallback1(() => dispatch(IncrementGlass), [dispatch])
    let decrement = React.useCallback1(() => dispatch(DecrementGlass), [dispatch])

    let hydrationAmount = React.useMemo1(() => Hydration.Logic.sumAmount(hydration), [hydration])
    let hydrationPercentage = React.useMemo2(
      () => Logic.drinkPercentage(Profile.hydrationGoal(profile), hydrationAmount),
      (profile, hydrationAmount),
    )

    <LVScreen>
      <LVHeader
        title="Hydration"
        right={<Pressable
          testID="avatar-button" onPress={_ => Authed.Navigation.navigate(navigation, "Profile")}>
          {_ => <Avatar.Text label={Profile.Logic.initials(profile)} size={42.0} />}
        </Pressable>}
      />
      <View style={styles["mainContainer"]}>
        <View style={styles["titleContainer"]}>
          <LVText.LargeTitle style={styles["title"]}>
            <Text> {React.string("Today you took ")} </Text>
            <Text testID="drunk-amount" style={styles["amount"]}>
              {React.string(Logic.amountToStr(hydrationAmount))}
            </Text>
            <Text> {React.string(" of water ")} </Text>
            <LVEmoji.Drop />
          </LVText.LargeTitle>
        </View>
        <View style={styles["progressContainer"]}>
          <Progress percentage={hydrationPercentage} />
        </View>
      </View>
      <View style={styles["bottomSheet"]}>
        <BottomSheet state onIncrement={increment} onDecrement={decrement} onAdd={add} />
      </View>
    </LVScreen>
  }
}

@react.component
let make = (~navigation, ~route as _) => {
  let profile = Api.Profile.use()
  let hydration = Api.Hydration.use()

  switch Api.concat2(profile, hydration) {
  | Api.Loaded((profile, hydration)) => <Loaded navigation profile hydration />
  | _ => <Text> {React.string("woops")} </Text>
  }
}
