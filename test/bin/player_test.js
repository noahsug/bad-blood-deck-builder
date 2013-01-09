(function() {

  describe('A player', function() {
    var opponent, player, summonSlime;
    player = opponent = void 0;
    beforeEach(function() {
      player = new Player(5);
      return opponent = new Player(5);
    });
    summonSlime = function() {
      var slime;
      slime = addCard(3, 1, 1);
      player.setCards(slime);
      opponent.setCards(slime);
      opponent.drawCard();
      player.drawCard();
      return player.reduceWait();
    };
    it('gets a deck of cards with setCards()', function() {
      player.setCards('wolf', 'soldier', 'wolf');
      return expect(player.deck.length).toBe(3);
    });
    it('draws a card from the deck into the waiting area with drawCard()', function() {
      player.setCards('wolf', 'soldier');
      expect(player.waiting.length).toBe(0);
      player.drawCard();
      expect(player.waiting.length).toBe(1);
      return expect(player.deck.length).toBe(1);
    });
    it('does nothing trying to draw a card with an empty deck', function() {
      player.setCards('wolf');
      player.drawCard();
      expect(player.waiting.length).toBe(1);
      expect(player.deck.length).toBe(0);
      player.drawCard();
      expect(player.waiting.length).toBe(1);
      return expect(player.deck.length).toBe(0);
    });
    it('reduces the wait time of all cards in the waiting area with reduceWait()', function() {
      var waitingCard;
      waitingCard = addCard(1, 1, 5);
      player.setCards(waitingCard, waitingCard, waitingCard);
      player.drawCard();
      player.reduceWait();
      player.drawCard();
      player.reduceWait();
      expect(player.waiting[0].wait).toBe(3);
      expect(player.waiting[1].wait).toBe(4);
      return expect(player.deck[0].wait).toBe(5);
    });
    it("moves a card from the waiting area to the field when a card's wait reaches 0", function() {
      var waitingCard;
      waitingCard = addCard(1, 1, 1);
      player.setCards(waitingCard);
      player.drawCard();
      player.reduceWait();
      expect(player.waiting.length).toBe(0);
      return expect(player.field.length).toBe(1);
    });
    it('returns the card at the given index in the field with getTarget()', function() {
      var waitingCard;
      waitingCard = addCard(1, 1, 1);
      player.setCards(waitingCard);
      player.drawCard();
      player.reduceWait();
      return expect(player.getTarget(0)).toBe(player.field[0]);
    });
    it('returns itself if no card exists at the given index', function() {
      return expect(player.getTarget(0)).toBe(player);
    });
    it('can attack and kill another player attack(player)', function() {
      summonSlime();
      player.attack(opponent);
      expect(opponent.health).toBe(2);
      player.attack(opponent);
      return expect(opponent.isAlive()).toBe(false);
    });
    it('can attack and kill another card with attack(player)', function() {
      summonSlime();
      opponent.reduceWait();
      player.attack(opponent);
      expect(opponent.field[0].isAlive()).toBe(false);
      return expect(opponent.health).toBe(5);
    });
    it('can remove dead cards with removeDead()', function() {
      summonSlime();
      opponent.reduceWait();
      player.attack(opponent);
      opponent.removeDead();
      return expect(opponent.field.length).toBe(0);
    });
    return it('is dead when no cards are left in the deck, waiting area and field', function() {
      summonSlime();
      opponent.reduceWait();
      player.attack(opponent);
      opponent.removeDead();
      return expect(opponent.isAlive()).toBe(false);
    });
  });

}).call(this);
