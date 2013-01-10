(function() {
  var Game;

  Game = (function() {

    function Game() {
      this.players = void 0;
      this.turn = 0;
    }

    Game.prototype.setPlayers = function(player, opponent) {
      player.name = 'Player';
      opponent.name = 'Opponent';
      player.setOpponent(opponent);
      opponent.setOpponent(player);
      return this.players = [player, opponent];
    };

    Game.prototype.run = function() {
      var attacker, defender, firstTurnOffset;
      firstTurnOffset = flipCoin() ? 0 : 1;
      while (this.players[0].isAlive() && this.players[1].isAlive() && !this.isTie()) {
        attacker = this.players[(this.turn + firstTurnOffset) % 2];
        defender = this.players[(this.turn + firstTurnOffset + 1) % 2];
        this.takeTurn(attacker, defender);
      }
      if (this.isTie()) {
        console.warn('ITS A TIE!!!!', this.turn);
      }
      return this.players[0].isAlive() && !this.isTie();
    };

    Game.prototype.takeTurn = function(attacker, defender) {
      attacker.reduceWait();
      defender.reduceWait();
      attacker.drawCard();
      attacker.attack();
      attacker.removeDead();
      defender.removeDead();
      return this.turn++;
    };

    Game.prototype.isTie = function() {
      return this.turn > 100;
    };

    Game.prototype.printState = function(attacker) {
      console.log("-------------------- TURN " + this.turn + " - " + attacker.name + " --------------------");
      console.log("# Player");
      this.players[0].printState();
      console.log("# Opponent");
      this.players[1].printState();
      return console.log('');
    };

    return Game;

  })();

  window.Game = Game;

}).call(this);
