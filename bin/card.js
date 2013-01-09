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
      this.effects = [];
      this.attackAbilities = [];
      this.defendAbilities = [];
    }

    Card.prototype.addAttackAbility = function(ability) {
      ability.setCard(this);
      return this.attackAbilities.push(ability);
    };

    Card.prototype.addDefendAbility = function(ability) {
      ability.setCard(this);
      return this.defendAbilities.push(ability);
    };

    Card.prototype.attack = function(opponent, position) {
      var ability, _i, _len, _ref;
      _ref = this.attackAbilities;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ability = _ref[_i];
        ability.actOn(opponent, position);
      }
      return opponent.getTargetAt(position).defend(this);
    };

    Card.prototype.defend = function(target) {
      var ability, _i, _len, _ref, _results;
      _ref = this.defendAbilities;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ability = _ref[_i];
        _results.push(ability.actOn(target));
      }
      return _results;
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
