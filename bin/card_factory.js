(function() {
  var CardFactory;

  CardFactory = (function() {

    function CardFactory() {}

    CardFactory.prototype.create = function(name) {
      var abilityClass, card, stats, _i, _len, _ref, _ref1;
      if (!(name in this.cards)) {
        throw "card " + name + " not found";
      }
      stats = this.cards[name];
      card = new Card(stats.health, stats.dmg, stats.wait);
      card.name = name;
      _ref1 = (_ref = stats.abilities) != null ? _ref : [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        abilityClass = _ref1[_i];
        card.addAbility(new abilityClass());
      }
      return card;
    };

    CardFactory.prototype.cards = {
      wolf: {
        wait: 2,
        health: 4,
        dmg: 1,
        abilities: [ability.Damage]
      },
      soldier: {
        wait: 2,
        health: 5,
        dmg: 1,
        abilities: [ability.Damage]
      }
    };

    return CardFactory;

  })();

  window.cardFactory = new CardFactory();

}).call(this);
