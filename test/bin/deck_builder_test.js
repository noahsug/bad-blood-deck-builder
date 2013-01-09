(function() {
  var __slice = [].slice;

  describe('A deck builder', function() {
    var builder;
    builder = void 0;
    beforeEach(function() {
      builder = new DeckBuilder();
      return builder.NUM_TRIALS = 500;
    });
    return it("6 1/2/2's is the best deck out of a card pool of 1/2/2's and 1/1/2's", function() {
      var decks, i, strongCard, strongDeck, weakCard, weakDeck;
      strongCard = addCard(1, 2, 2);
      weakCard = addCard(1, 1, 2);
      strongDeck = (function() {
        var _i, _results;
        _results = [];
        for (i = _i = 1; _i <= 6; i = ++_i) {
          _results.push(strongCard);
        }
        return _results;
      })();
      weakDeck = (function() {
        var _i, _results;
        _results = [];
        for (i = _i = 1; _i <= 6; i = ++_i) {
          _results.push(weakCard);
        }
        return _results;
      })();
      builder.setPlayerCards.apply(builder, __slice.call(strongDeck).concat(__slice.call(weakDeck)));
      builder.addOpponentDeck.apply(builder, strongDeck);
      builder.addOpponentDeck.apply(builder, __slice.call(strongDeck.slice(0, 3)).concat(__slice.call(weakDeck.slice(0, 3))));
      decks = builder.getBestDecks();
      return expect(decks[0].sort().toString()).toBe(strongDeck.sort().toString());
    });
  });

}).call(this);
