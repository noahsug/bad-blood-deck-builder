(function() {

  describe('Util provides the following functions', function() {
    describe('removeAtRandom', function() {
      it('removes and returns an element from the array', function() {
        var arr, i, removed, _i, _results;
        _results = [];
        for (i = _i = 1; _i <= 5; i = ++_i) {
          arr = [1, 2, 3];
          removed = removeAtRandom(arr);
          expect([1, 2, 3].indexOf(removed) >= 0).toBe(true);
          expect(arr.indexOf(removed)).toBe(-1);
          _results.push(expect(arr.length).toBe(2));
        }
        return _results;
      });
      it('the element removed in randomly selected', function() {
        var a, b, i, removedADifferentElement, removedDifferentElement, removedSameElement, _i;
        removedDifferentElement = false;
        removedSameElement = false;
        for (i = _i = 1; _i <= 30; i = ++_i) {
          a = removeAtRandom([1, 2, 3]);
          b = removeAtRandom([1, 2, 3]);
          if (a === b) {
            removedSameElement = true;
          } else {
            removedADifferentElement = true;
          }
        }
        return expect(removedSameElement && removedADifferentElement).toBe(true);
      });
      return it('does nothing on an empty array', function() {
        var arr, i, _i;
        arr = [1, 2, 3];
        for (i = _i = 1; _i <= 4; i = ++_i) {
          removeAtRandom(arr);
        }
        return expect(arr.length).toBe(0);
      });
    });
    describe('flipCoin', function() {
      return it('randomly returns true or false', function() {
        var i, wasFalse, wasTrue, _i;
        wasTrue = false;
        wasFalse = false;
        for (i = _i = 1; _i <= 20; i = ++_i) {
          if (flipCoin()) {
            wasTrue = true;
          } else {
            wasFalse = true;
          }
        }
        return expect(wasTrue && wasFalse).toBe(true);
      });
    });
    describe('shuffle', function() {
      return it('returns the array with its elements in a random order', function() {
        var arr, i, numDifferent, originalArr, prev, _i;
        originalArr = [1, 2, 3, 4, 5];
        arr = originalArr.slice(0);
        numDifferent = 0;
        for (i = _i = 1; _i <= 10; i = ++_i) {
          prev = arr.toString();
          shuffle(arr);
          if (arr.toString() !== prev) {
            numDifferent++;
          }
          expect(arr.slice(0).sort()).toEqual(originalArr);
        }
        return expect(numDifferent >= 8).toBe(true);
      });
    });
    describe('removeAtIndexes', function() {
      it('removes elements from an array at the given indexes', function() {
        var arr;
        arr = [1, 2, 3, 4];
        removeAtIndexes(arr, [1, 3]);
        return expect(arr).toEqual([1, 3]);
      });
      return it('returns the removed elements', function() {
        var arr, removed;
        arr = [5, 6, 7];
        removed = removeAtIndexes(arr, [0, 2]);
        return expect(removed).toEqual([5, 7]);
      });
    });
    return describe('pad', function() {
      return it('adds whitespace or removes charaacters until the text has the desired length', function() {
        expect(pad('bob', 5)).toBe('bob  ');
        expect(pad('bob', 4)).toBe('bob ');
        expect(pad('bob', 3)).toBe('bob');
        expect(pad('bob', 2)).toBe('bo');
        return expect(pad('bob', 0)).toBe('');
      });
    });
  });

}).call(this);
