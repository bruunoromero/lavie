open ReactNative
open Style

let useStyles = Theme.makeStyles(_ =>
  {
    "container": viewStyle(~margin=0.0->dp, ()),
  }
)

@react.component
let make = (~isOpen) => {
  let styles = useStyles()

  <ReactNativeModal style={styles["container"]} isVisible=isOpen hasBackdrop=false>
    <LVScreen>
      <LVHeader title="Onboarding" /> <View> <Text> {React.string("ola mundo")} </Text> </View>
    </LVScreen>
  </ReactNativeModal>
}
