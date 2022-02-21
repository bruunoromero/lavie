// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as Auth from "firebase/auth";

var User = {};

var Credential = {};

var Provider = {};

var partial_arg = Auth.GoogleAuthProvider;

function credential(param) {
  return partial_arg.credential(param);
}

var GoogleProvider = {
  credential: credential
};

function onAuthStateChanged(auth, cb) {
  return Auth.onAuthStateChanged(auth, (function (user) {
                return Curry._1(cb, (user == null) ? undefined : Caml_option.some(user));
              }));
}

var Auth$1 = {
  Credential: Credential,
  Provider: Provider,
  GoogleProvider: GoogleProvider,
  onAuthStateChanged: onAuthStateChanged
};

export {
  User ,
  Auth$1 as Auth,
  
}
/* partial_arg Not a pure module */
