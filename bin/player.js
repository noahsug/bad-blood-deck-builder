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

    Player.prototype.setCards = function() {
      var cardNames, name;
      cardNames = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.deck = shuffle((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = cardNames.length; _i < _len; _i++) {
          name = cardNames[_i];
          _results.push(cardFactory.create(name));
        }
        return _results;
      })());
      return this.id = ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = cardNames.length; _i < _len; _i++) {
          name = cardNames[_i];
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

    Player.prototype.attack = function(opponent) {
      var card, i, _i, _len, _ref, _results;
      _ref = this.field;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        card = _ref[i];
        _results.push(card.attack(opponent.getTarget(i)));
      }
      return _results;
    };

    Player.prototype.getTarget = function(index) {
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
