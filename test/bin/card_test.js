(function() {

  describe('A card', function() {
    var attack, soldier, wolf;
    attack = wolf = soldier = void 0;
    beforeEach(function() {
      wolf = cardFactory.create(addCard(1, 4, 2));
      return soldier = cardFactory.create(addCard(1, 5, 2));
    });
    attack = function(attackingCard, defendingCard) {
      var opponent, player;
      player = {};
      opponent = {};
      opponent.getTargetAt = function() {
        return defendingCard;
      };
      opponent.opponent = player;
      defendingCard.owner = opponent;
      player.opponent = opponent;
      player.getTargetAt = function() {
        return attackingCard;
      };
      attackingCard.owner = player;
      return attackingCard.attack();
    };
    it('is created using a card factory', function() {
      return expect(wolf).toBeDefined();
    });
    it('has wait, health, dmg and abilities', function() {
      expect(wolf.wait).toBeDefined();
      expect(wolf.health).toBeDefined();
      expect(wolf.dmg).toBeDefined();
      return expect(wolf.abilities).toBeDefined();
    });
    it('can attack another card', function() {
      expect(soldier.health).toBe(cardFactory.cards.soldier.health);
      attack(wolf, soldier);
      return expect(soldier.health).toBe(cardFactory.cards.soldier.health - 1);
    });
    return it('dies when health is 0 or less', function() {
      var oneHealthCreature;
      oneHealthCreature = cardFactory.create(addCard(1, 1, 1));
      expect(oneHealthCreature.isAlive()).toBe(true);
      attack(wolf, oneHealthCreature);
      return expect(oneHealthCreature.isAlive()).toBe(false);
    });
  });

}).call(this);
