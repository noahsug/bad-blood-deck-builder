(function() {

  describe('A card', function() {
    var soldier, wolf;
    wolf = soldier = void 0;
    beforeEach(function() {
      wolf = cardFactory.create('wolf');
      return soldier = cardFactory.create('soldier');
    });
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
      wolf.attack(soldier);
      return expect(soldier.health).toBe(cardFactory.cards.soldier.health - 1);
    });
    it('defends when attacked', function() {
      spyOn(soldier, 'defend');
      wolf.attack(soldier);
      return expect(soldier.defend).toHaveBeenCalled();
    });
    return it('dies when health is 0 or less', function() {
      var oneHealthCreature;
      oneHealthCreature = cardFactory.create(addCard(1, 1, 1));
      expect(oneHealthCreature.isAlive()).toBe(true);
      wolf.attack(oneHealthCreature);
      return expect(oneHealthCreature.isAlive()).toBe(false);
    });
  });

}).call(this);
