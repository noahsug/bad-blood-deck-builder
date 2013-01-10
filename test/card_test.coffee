describe 'A card', ->
  attack = wolf = soldier = undefined

  beforeEach ->
    wolf = cardFactory.create addCard 1, 4, 2
    soldier = cardFactory.create addCard 1, 5, 2

  attack = (attackingCard, defendingCard) ->
    player = {}
    opponent = {}
    opponent.getTargetAt = -> defendingCard
    opponent.opponent = player
    defendingCard.owner = opponent

    player.opponent = opponent
    player.getTargetAt = -> attackingCard
    attackingCard.owner = player

    attackingCard.attack()

  it 'is created using a card factory', ->
    expect(wolf).toBeDefined()

  it 'has wait, health, dmg and abilities', ->
    expect(wolf.wait).toBeDefined()
    expect(wolf.health).toBeDefined()
    expect(wolf.dmg).toBeDefined()
    expect(wolf.abilities).toBeDefined()

  it 'can attack another card', ->
    expect(soldier.health).toBe cardFactory.cards.soldier.health
    attack wolf, soldier
    expect(soldier.health).toBe cardFactory.cards.soldier.health - 1

  it 'dies when health is 0 or less', ->
    oneHealthCreature = cardFactory.create addCard 1, 1, 1
    expect(oneHealthCreature.isAlive()).toBe true
    attack wolf, oneHealthCreature
    expect(oneHealthCreature.isAlive()).toBe false
