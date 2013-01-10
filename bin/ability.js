(function() {
  var Ability, Damage, Sap, exportClass, exports, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  exports = (_ref = window.ability) != null ? _ref : window.ability = {};

  exportClass = function(ability) {
    return exports[ability.name] = ability;
  };

  Ability = (function() {

    function Ability() {}

    Ability.prototype.setCard = function(card) {
      var _this = this;
      this.card = card;
      return this.card.on('attack', function() {
        return typeof _this.onAttack === "function" ? _this.onAttack() : void 0;
      });
    };

    Ability.prototype.target = function() {
      return this.card.owner.opponent.getTargetAt(this.card.position);
    };

    return Ability;

  })();

  Damage = (function(_super) {

    __extends(Damage, _super);

    function Damage() {
      return Damage.__super__.constructor.apply(this, arguments);
    }

    Damage.prototype.onAttack = function() {
      return this.target().onAttacked(this.card, this.card.getDmg());
    };

    return Damage;

  })(Ability);

  exportClass(Damage);

  Sap = (function(_super) {

    __extends(Sap, _super);

    function Sap(amount) {
      this.amount = amount != null ? amount : 1;
    }

    Sap.prototype.onAttack = function() {
      return this.target().effects.dmgModifier -= 1;
    };

    return Sap;

  })(Ability);

  exportClass(Sap);

}).call(this);
