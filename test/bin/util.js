(function() {
  var exports;

  exports = window;

  exports.addCard = function(dmg, health, wait, attackAbilities, defendingAbilities) {
    var name;
    if (attackAbilities == null) {
      attackAbilities = [];
    }
    if (defendingAbilities == null) {
      defendingAbilities = [];
    }
    name = "" + dmg + "/" + health + "/" + wait;
    cardFactory.cards[name] = {
      dmg: dmg,
      health: health,
      wait: wait,
      attackAbilities: attackAbilities,
      defendingAbilities: defendingAbilities
    };
    return name;
  };

}).call(this);
