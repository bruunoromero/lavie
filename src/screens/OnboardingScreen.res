open ReactNative
open Style

@react.component
let make = (~isOpen: bool) => {
  <ReactNativeModal style={viewStyle(~margin=0.0->dp, ())} isVisible=isOpen hasBackdrop=false>
    <View style={viewStyle(~flex=1.0, ~backgroundColor="#fff", ())}>
      <Header title="Onboarding" /> <View> <Text> {React.string("ola mundo")} </Text> </View>
    </View>
  </ReactNativeModal>
}
