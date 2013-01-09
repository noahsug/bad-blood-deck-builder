(function() {
  var DeckBuilder,
    __slice = [].slice;

  DeckBuilder = (function() {

    DeckBuilder.prototype.NUM_TRIALS = 10000;

    DeckBuilder.prototype.PLAYER_HP = 25;

    function DeckBuilder() {
      this.opponentDecks = [];
    }

    DeckBuilder.prototype.addOpponentDeck = function() {
      var opponentCards;
      opponentCards = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this.opponentDecks.push(opponentCards);
    };

    DeckBuilder.prototype.setPlayerCards = function() {
      var playerCards;
      playerCards = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.playerCards = playerCards;
    };

    DeckBuilder.prototype.printResults = function() {
      var decks, i, opponentDeck, playerDeck, _i, _len, _results;
      decks = this.getBestDecks();
      _results = [];
      for (i = _i = 0, _len = decks.length; _i < _len; i = ++_i) {
        playerDeck = decks[i];
        console.log("#" + (decks.length - i) + " wins " + (Math.round(playerDeck.totalScore)) + "% " + playerDeck);
        _results.push((function() {
          var _j, _len1, _ref, _results1;
          _ref = this.opponentDecks;
          _results1 = [];
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            opponentDeck = _ref[_j];
            _results1.push(console.log('  ', playerDeck.scoreMap[opponentDeck], 'vs', opponentDeck.toString()));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    DeckBuilder.prototype.getBestDecks = function() {
      var opponentDeck, playerDeck, playerDecks, score, _i, _j, _len, _len1, _ref;
      playerDecks = this.getPossibleDecks();
      console.log(playerDecks.length, 'possible decks found');
      console.log('');
      for (_i = 0, _len = playerDecks.length; _i < _len; _i++) {
        playerDeck = playerDecks[_i];
        playerDeck.totalScore = 0;
        playerDeck.scoreMap = {};
        console.log('Intermediate scores for', playerDeck.toString());
        _ref = this.opponentDecks;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          opponentDeck = _ref[_j];
          score = this.scoreDeck(playerDeck, opponentDeck);
          console.log(score, 'vs', opponentDeck.toString());
          playerDeck.scoreMap[opponentDeck] = score;
          playerDeck.totalScore += score;
        }
        playerDeck.totalScore /= this.opponentDecks.length;
        console.log('');
      }
      return playerDecks.sort(function(a, b) {
        return a.totalScore - b.totalScore;
      });
    };

    DeckBuilder.prototype.scoreDeck = function(playerDeck, opponentDeck) {
      var game, i, wins, _i, _ref;
      wins = 0;
      for (i = _i = 1, _ref = this.NUM_TRIALS; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        game = this.createGame(playerDeck, opponentDeck);
        if (game.run()) {
          wins++;
        }
      }
      return wins * 100 / this.NUM_TRIALS;
    };

    DeckBuilder.prototype.createGame = function(playerDeck, opponentDeck) {
      var game, opponent, player;
      game = new Game();
      player = new Player(this.PLAYER_HP);
      player.setCards.apply(player, playerDeck);
      opponent = new Player(this.PLAYER_HP);
      opponent.setCards.apply(opponent, opponentDeck);
      game.setPlayers(player, opponent);
      return game;
    };

    DeckBuilder.prototype.getPossibleDecks = function() {
      var deck, id, maxDeckSize, uniqueDecks, _results,
        _this = this;
      maxDeckSize = 6;
      uniqueDecks = {};
      this.forEachDeckCombination(function(cardIndexes) {
        var deck, i;
        deck = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = cardIndexes.length; _i < _len; _i++) {
            i = cardIndexes[_i];
            _results.push(this.playerCards[i]);
          }
          return _results;
        }).call(_this);
        return uniqueDecks[deck.sort()] = deck;
      });
      _results = [];
      for (id in uniqueDecks) {
        deck = uniqueDecks[id];
        _results.push(deck);
      }
      return _results;
    };

    DeckBuilder.prototype.forEachDeckCombination = function(callback, position, indexes) {
      var i, start, _i, _ref;
      if (position == null) {
        position = 0;
      }
      if (indexes == null) {
        indexes = new Array(6);
      }
      start = position === 0 ? 0 : indexes[position - 1] + 1;
      for (i = _i = start, _ref = this.playerCards.length - 1; start <= _ref ? _i <= _ref : _i >= _ref; i = start <= _ref ? ++_i : --_i) {
        indexes[position] = i;
        if (position === 5) {
          callback(indexes);
        } else if (i < this.playerCards.length - 1) {
          this.forEachDeckCombination(callback, position + 1, indexes);
        }
      }
      return true;
    };

    return DeckBuilder;

  })();

  window.DeckBuilder = DeckBuilder;

}).call(this);
