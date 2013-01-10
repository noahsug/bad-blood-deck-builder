(function() {
  var Card,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Card = (function(_super) {

    __extends(Card, _super);

    function Card(initHealth, initDmg, initWait) {
      this.initDmg = initDmg;
      this.initWait = initWait;
      Card.__super__.constructor.call(this, initHealth);
      this.dmg = this.initDmg;
      this.wait = this.initWait;
      this.abilities = [];
      this.position = void 0;
      this.owner = void 0;
      this.opponent = void 0;
      this.initializeEffects();
    }

    Card.prototype.initializeEffects = function() {
      this.effects = {};
      return this.effects.dmgModifier = 0;
    };

    Card.prototype.addAbility = function(ability) {
      ability.setCard(this);
      return this.abilities.push(ability);
    };

    Card.prototype.attack = function() {
      this.emit('preattack');
      if (this.getDmg() > 0) {
        return this.emit('attack');
      }
    };

    Card.prototype.getDmg = function() {
      return this.dmg += this.effects.dmgModifier;
    };

    Card.prototype.getState = function() {
      return "" + this.dmg + "/" + this.health + "/" + this.wait;
    };

    Card.prototype.toString = function() {
      return this.name;
    };

    return Card;

  })(Target);

  window.Card = Card;

}).call(this);
