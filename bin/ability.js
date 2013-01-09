(function() {
  var Ability, Damage, exportClass, exports, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  exports = (_ref = window.ability) != null ? _ref : window.ability = {};

  exportClass = function(ability) {
    return exports[ability.name] = ability;
  };

  Ability = (function() {

    function Ability() {}

    Ability.prototype.setCard = function(card) {
      this.card = card;
    };

    Ability.prototype.actOn = function(opponent, position) {
      this.opponent = opponent;
      this.position = position;
    };

    return Ability;

  })();

  Damage = (function(_super) {

    __extends(Damage, _super);

    function Damage() {
      return Damage.__super__.constructor.apply(this, arguments);
    }

    Damage.prototype.actOn = function(opponent, position) {
      return opponent.getTargetAt(position).health -= this.card.dmg;
    };

    return Damage;

  })(Ability);

  exportClass(Damage);

}).call(this);
