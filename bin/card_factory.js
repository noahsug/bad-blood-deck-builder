(function() {
  var CardFactory;

  CardFactory = (function() {

    function CardFactory() {}

    CardFactory.prototype.create = function(name) {
      var attackAbility, card, defendAbility, stats, _i, _j, _len, _len1, _ref, _ref1, _ref2, _ref3;
      if (!(name in this.cards)) {
        throw "card " + name + " not found";
      }
      stats = this.cards[name];
      card = new Card(stats.health, stats.dmg, stats.wait);
      card.name = name;
      _ref1 = (_ref = stats.attackAbilities) != null ? _ref : [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        attackAbility = _ref1[_i];
        card.addAttackAbility(attackAbility);
      }
      _ref3 = (_ref2 = stats.defendAbilities) != null ? _ref2 : [];
      for (_j = 0, _len1 = _ref3.length; _j < _len1; _j++) {
        defendAbility = _ref3[_j];
        card.addDefendAbility(defendAbility);
      }
      return card;
    };

    CardFactory.prototype.cards = {
      wolf: {
        wait: 2,
        health: 4,
        dmg: 1,
        attackAbilities: [new ability.Damage()]
      },
      soldier: {
        wait: 2,
        health: 5,
        dmg: 1,
        attackAbilities: [new ability.Damage()]
      }
    };

    return CardFactory;

  })();

  window.cardFactory = new CardFactory();

}).call(this);
