(function() {

  describe('A card', function() {
    var attack, soldier, wolf;
    attack = wolf = soldier = void 0;
    beforeEach(function() {
      wolf = cardFactory.create(addCard(1, 4, 2));
      return soldier = cardFactory.create(addCard(1, 5, 2));
    });
    attack = function(attackingCard, defendingCard) {
      var opponent;
      opponent = {
        getTargetAt: function() {
          return defendingCard;
        }
      };
      return attackingCard.attack(opponent);
    };
    it('is created using a card factory', function() {
      return expect(wolf).toBeDefined();
    });
    it('has wait, health, dmg, attackAbilities and defendAbilities', function() {
      expect(wolf.wait).toBeDefined();
      expect(wolf.health).toBeDefined();
      expect(wolf.dmg).toBeDefined();
      expect(wolf.attackAbilities).toBeDefined();
      return expect(wolf.defendAbilities).toBeDefined();
    });
    it('can attack another card', function() {
      expect(soldier.health).toBe(cardFactory.cards.soldier.health);
      attack(wolf, soldier);
      return expect(soldier.health).toBe(cardFactory.cards.soldier.health - 1);
    });
    it('defends when attacked', function() {
      spyOn(soldier, 'defend');
      attack(wolf, soldier);
      return expect(soldier.defend).toHaveBeenCalled();
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
