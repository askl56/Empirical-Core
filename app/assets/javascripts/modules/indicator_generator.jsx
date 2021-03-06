'use strict';
EC.modules.IndicatorGenerator = function (getModelState, setModelState, fnl) {

  this.stateItemToggler = function (key) {
    return function (item, boolean) {
      var x = fnl.toggle(getModelState(key), item);
      setModelState(key, x);
    }
  };

  this.selector = function (key) {
    return function (value) {
      setModelState(key, value);
    }
  };
}