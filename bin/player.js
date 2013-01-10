(function() {
  var Player,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  Player = (function(_super) {

    __extends(Player, _super);

    function Player(initHealth) {
      Player.__super__.constructor.call(this, initHealth);
      this.field = [];
      this.waiting = [];
      this.deck = [];
    }

    Player.prototype.setOpponent = function(opponent) {
      this.opponent = opponent;
    };

    Player.prototype.setCards = function() {
      var card, cardNames, name, _i, _len;
      cardNames = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.deck = [];
      for (_i = 0, _len = cardNames.length; _i < _len; _i++) {
        name = cardNames[_i];
        card = cardFactory.create(name);
        this.deck.push(card);
        card.owner = this;
      }
      shuffle(this.deck);
      return this.id = ((function() {
        var _j, _len1, _results;
        _results = [];
        for (_j = 0, _len1 = cardNames.length; _j < _len1; _j++) {
          name = cardNames[_j];
          _results.push(name);
        }
        return _results;
      })()).join(', ');
    };

    Player.prototype.reduceWait = function() {
      var card, newWaiting, _i, _len, _ref;
      newWaiting = [];
      _ref = this.waiting;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        card.wait -= 1;
        if (card.wait <= 0) {
          this.field.push(card);
          card.position = this.field.length - 1;
        } else {
          newWaiting.push(card);
        }
      }
      return this.waiting = newWaiting;
    };

    Player.prototype.drawCard = function() {
      if (this.deck.length > 0) {
        return this.waiting.push(this.deck.pop());
      }
    };

    Player.prototype.attack = function() {
      var card, _i, _len, _ref, _results;
      _ref = this.field;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        _results.push(card.attack());
      }
      return _results;
    };

    Player.prototype.getTargetAt = function(index) {
      if (this.field.length > index && this.field[index].isAlive()) {
        return this.field[index];
      } else {
        return this;
      }
    };

    Player.prototype.removeDead = function() {
      var card, newField, _i, _len, _ref;
      newField = [];
      _ref = this.field;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        if (card.isAlive()) {
          newField.push(card);
          card.position = newField.length - 1;
        }
      }
      return this.field = newField;
    };

    Player.prototype.isAlive = function() {
      return Player.__super__.isAlive.call(this) && (this.field.length > 0 || this.deck.length > 0 || this.waiting.length > 0);
    };

    Player.prototype.printState = function() {
      var card;
      console.log("Health: " + this.health + ", Deck: " + this.deck.length + ", Waiting: " + this.waiting.length);
      return console.log(((function() {
        var _i, _len, _ref, _results;
        _ref = this.field;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          card = _ref[_i];
          _results.push("[ " + (card.getState()) + " ]");
        }
        return _results;
      }).call(this)).join(' '));
    };

    Player.prototype.toString = function() {
      return this.id;
    };

    return Player;

  })(Target);

  window.Player = Player;

}).call(this);
