describe 'Util provides the following functions', ->
  describe 'removeAtRandom', ->

    it 'removes and returns an element from the array', ->
      for i in [1..5]
        arr = [1, 2, 3]
        removed = removeAtRandom arr
        expect([1, 2, 3].indexOf(removed) >= 0).toBe true
        expect(arr.indexOf removed).toBe -1
        expect(arr.length).toBe 2

    it 'the element removed in randomly selected', ->
      removedDifferentElement = false
      removedSameElement = false
      for i in [1..30]
        a = removeAtRandom [1, 2, 3]
        b = removeAtRandom [1, 2, 3]
        if a == b
          removedSameElement = true
        else
          removedADifferentElement = true
      expect(removedSameElement and removedADifferentElement).toBe true

    it 'does nothing on an empty array', ->
      arr = [1, 2, 3]
      for i in [1..4]
        removeAtRandom arr
      expect(arr.length).toBe 0

  describe 'flipCoin', ->

    it 'randomly returns true or false', ->
      wasTrue = false
      wasFalse = false
      for i in [1..20]
        if flipCoin()
          wasTrue = true
        else
          wasFalse = true
      expect(wasTrue and wasFalse).toBe true

  describe 'shuffle', ->

    it 'returns the array with its elements in a random order', ->
      originalArr = [1, 2, 3, 4, 5]
      arr = originalArr[..]
      numDifferent = 0
      for i in [1..10]
        prev = arr.toString()
        shuffle arr
        numDifferent++ unless arr.toString() is prev
        expect(arr[..].sort()).toEqual originalArr
      expect(numDifferent >= 8).toBe true

  describe 'removeAtIndexes', ->

    it 'removes elements from an array at the given indexes', ->
      arr = [1, 2, 3, 4]
      removeAtIndexes arr, [1, 3]
      expect(arr).toEqual [1, 3]

    it 'returns the removed elements', ->
      arr = [5, 6, 7]
      removed = removeAtIndexes arr, [0, 2]
      expect(removed).toEqual [5, 7]

  describe 'pad', ->

    it 'adds whitespace or removes charaacters until the text has the desired length', ->
      expect(pad 'bob', 5).toBe 'bob  '
      expect(pad 'bob', 4).toBe 'bob '
      expect(pad 'bob', 3).toBe 'bob'
      expect(pad 'bob', 2).toBe 'bo'
      expect(pad 'bob', 0).toBe ''
