open ReactNative

module Human = {
  type t

  @module("react-native-typography")
  external _human: t = "human"

  @get
  external _largeTitle: t => Style.t = "largeTitle"

  @get
  external _title1: t => Style.t = "title1"

  @get
  external _title2: t => Style.t = "title2"

  @get
  external _title3: t => Style.t = "title3"

  @get
  external _headline: t => Style.t = "headline"

  @get
  external _body: t => Style.t = "body"

  @get
  external _callout: t => Style.t = "callout"

  @get
  external _subhead: t => Style.t = "subhead"

  @get
  external _footnote: t => Style.t = "footnote"

  @get
  external _caption1: t => Style.t = "caption1"

  @get
  external _caption2: t => Style.t = "caption2"

  let largeTitle = _largeTitle(_human)
  let title1 = _title1(_human)
  let title2 = _title2(_human)
  let title3 = _title3(_human)
  let headline = _headline(_human)
  let body = _body(_human)
  let callout = _callout(_human)
  let subhead = _subhead(_human)
  let footnote = _footnote(_human)
  let caption1 = _caption1(_human)
  let caption2 = _caption2(_human)
}
