@val external describe: (string, @uncurry (unit => unit)) => unit = "describe"

@val external it: (string, @uncurry (unit => unit)) => unit = "it"
@val external itAsync: (string, @uncurry (unit => Promise.t<unit>)) => unit = "it"

@val external test: (string, @uncurry (unit => unit)) => unit = "test"
@val external testAsync: (string, @uncurry (unit => Promise.t<unit>)) => unit = "test"

type expect
@get external not: expect => expect = "not"
@val external expect: 'a => expect = "expect"
@send external toBe: (expect, 'a) => unit = "toBe"
@send external toEqual: (expect, 'a) => unit = "toEqual"
@send external toMatchSnapshot: expect => unit = "toMatchSnapshot"
@send external toHaveBeenCalled: expect => unit = "toHaveBeenCalled"
@send external toHaveBeenCalledWith: (expect, 'a) => unit = "toHaveBeenCalledWith"
@send external toHaveBeenCalledTimes: (expect, int) => unit = "toHaveBeenCalledTimes"

type fn1<'a, 'b> = @uncurry ('a => 'b)
type fn2<'a, 'b, 'c> = @uncurry ('a, 'b) => 'c
type fn3<'a, 'b, 'c, 'd> = @uncurry ('a, 'b, 'c) => 'd
type fn4<'a, 'b, 'c, 'd, 'e> = @uncurry ('a, 'b, 'c, 'd) => 'e

@val external fn: fn1<'a, 'b> => fn1<'a, 'b> = "jest.fn"
@val external fn2: fn2<'a, 'b, 'c> => fn2<'a, 'b, 'c> = "jest.fn"
@val external fn3: fn3<'a, 'b, 'c, 'd> => fn3<'a, 'b, 'c, 'd> = "jest.fn"
@val external fn4: fn4<'a, 'b, 'c, 'd, 'e> => fn4<'a, 'b, 'c, 'd, 'e> = "jest.fn"

@val external _beforeEach: (unit => unit) => unit = "beforeEach"

let beforeEach = fn => {
  fn()
  ignore()
}
