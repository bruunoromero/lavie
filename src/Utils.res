module OptionEx = {
  let do = (opt, op) =>
    switch opt {
    | Some(data) => op(data)
    | None => ignore()
    }

  let do2 = (first, second, op) => {
    switch (first, second) {
    | (Some(f), Some(s)) => op(f, s)
    | _ => ignore()
    }
  }
}

module Strings = {
  let charToString = char => String.make(1, char)
  let first = str => str->String.unsafe_get(0)->charToString

  let split = (str, char) => List.toArray(String.split_on_char(char, str))
}

let unwrapComponent = comp => {
  switch comp {
  | Some(c) => c
  | None => React.null
  }
}

module Floats = {
  let toRate = pct => pct *. 100.0
}
