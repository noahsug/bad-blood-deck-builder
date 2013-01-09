(function() {
  var exports;

  exports = window;

  exports.shuffle = function(arr) {
    var i, j, _ref;
    i = arr.length;
    if (i === 0) {
      return false;
    }
    while (--i) {
      j = Math.floor(Math.random() * (i + 1));
      _ref = [arr[j], arr[i]], arr[i] = _ref[0], arr[j] = _ref[1];
    }
    return arr;
  };

  exports.removeAtRandom = function(arr) {
    return arr.splice(Math.random() * Math.floor(arr.length), 1)[0];
  };

  exports.removeAtIndexes = function(arr, indexes) {
    var i, index, _i, _len, _results;
    _results = [];
    for (i = _i = 0, _len = indexes.length; _i < _len; i = ++_i) {
      index = indexes[i];
      _results.push(arr.splice(index - i, 1)[0]);
    }
    return _results;
  };

  exports.flipCoin = function() {
    return Math.random() < .5;
  };

  exports.pad = function(text, width) {
    var i;
    if (text.length === width) {
      return text;
    } else if (width === 0) {
      return '';
    } else if (text.length > width) {
      return text.slice(0, +(width - 1) + 1 || 9e9);
    } else {
      return text + ((function() {
        var _i, _ref, _ref1, _results;
        _results = [];
        for (i = _i = _ref = text.length, _ref1 = width - 1; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; i = _ref <= _ref1 ? ++_i : --_i) {
          _results.push(' ');
        }
        return _results;
      })()).join('');
    }
  };

}).call(this);
