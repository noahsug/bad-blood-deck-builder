(function() {

  describe('A game', function() {
    var createGame, game, player1, player2;
    game = player1 = player2 = void 0;
    createGame = function() {
      player1 = new Player(20);
      player2 = new Player(20);
      game = new Game();
      return game.setPlayers(player1, player2);
    };
    it('has a winner', function() {
      createGame();
      player1.setCards('wolf');
      player2.setCards('wolf');
      return expect(game.run()).toBeDefined();
    });
    it('1/2/2 always beats 1/1/2', function() {
      var i, _i, _results;
      _results = [];
      for (i = _i = 1; _i <= 5; i = ++_i) {
        createGame();
        player1.setCards(addCard(1, 2, 2));
        player2.setCards(addCard(1, 1, 2));
        _results.push(expect(game.run()).toBe(true));
      }
      return _results;
    });
    it("3 1/2/2's always beat 3 1/1/2's", function() {
      var i, _i, _results;
      _results = [];
      for (i = _i = 1; _i <= 5; i = ++_i) {
        createGame();
        player1.setCards(addCard(1, 2, 2), addCard(1, 2, 2), addCard(1, 2, 2));
        player2.setCards(addCard(1, 1, 2), addCard(1, 1, 2), addCard(1, 1, 2));
        _results.push(expect(game.run()).toBe(true));
      }
      return _results;
    });
    it('1/1/2 sometimes beats 1/1/2', function() {
      var i, lost, won, _i;
      won = false;
      lost = false;
      for (i = _i = 0; _i <= 10; i = ++_i) {
        createGame();
        player1.setCards(addCard(1, 1, 2));
        player2.setCards(addCard(1, 1, 2));
        if (game.run()) {
          won = true;
        } else {
          lost = true;
        }
      }
      return expect(won && lost).toBe(true);
    });
    it("3 1/5/2's sometimes beats 3 1/5/2's", function() {
      var i, lost, won, _i;
      won = false;
      lost = false;
      for (i = _i = 0; _i <= 10; i = ++_i) {
        createGame();
        player1.setCards(addCard(1, 1, 2));
        player2.setCards(addCard(1, 1, 2));
        if (game.run()) {
          won = true;
        } else {
          lost = true;
        }
      }
      return expect(won && lost).toBe(true);
    });
    return it('1/1/2 always loses to 1/1/4', function() {
      var i, _i, _results;
      _results = [];
      for (i = _i = 1; _i <= 5; i = ++_i) {
        createGame();
        player1.setCards(addCard(1, 1, 2));
        player2.setCards(addCard(1, 1, 4));
        _results.push(expect(game.run()).toBe(false));
      }
      return _results;
    });
  });

}).call(this);
