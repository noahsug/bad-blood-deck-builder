(function() {
  var exports;

  exports = window;

  exports.addCard = function(dmg, health, wait, abilities) {
    var name;
    if (abilities == null) {
      abilities = [];
    }
    name = "" + dmg + "/" + health + "/" + wait;
    cardFactory.cards[name] = {
      dmg: dmg,
      health: health,
      wait: wait,
      abilities: abilities
    };
    return name;
  };

}).call(this);
