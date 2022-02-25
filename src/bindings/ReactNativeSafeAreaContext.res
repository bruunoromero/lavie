// import {
//   SafeAreaView,
//   SafeAreaProvider,
//   SafeAreaInsetsContext,
//   useSafeAreaInsets,
//   initialWindowMetrics,
// } from 'react-native-safe-area-context';
open ReactNative

module SafeAreaProvider = {
  @module("react-native-safe-area-context") @react.component
  external make: (~children: React.element) => React.element = "SafeAreaProvider"
}

module SafeAreaView = {
  @module("react-native-safe-area-context") @react.component
  external make: (~children: React.element, ~style: Style.t=?) => React.element = "SafeAreaView"
}
