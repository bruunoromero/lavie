module Appbar = {
  module Header = {
    @module("./ReactNativePaper.js") @react.component
    external make: (~children: React.element) => React.element = "AppbarHeader"
  }
  
  module Content = {
    @module("./ReactNativePaper.js") @react.component
    external make: (~title: string) => React.element = "AppbarContent"
  }
}
