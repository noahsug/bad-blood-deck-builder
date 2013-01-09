describe 'A card', ->
  attack = wolf = soldier = undefined

  beforeEach ->
    wolf = cardFactory.create addCard 1, 4, 2
    soldier = cardFactory.create addCard 1, 5, 2

  attack = (attackingCard, defendingCard) ->
    opponent = { getTargetAt: -> defendingCard }
    attackingCard.attack opponent

  it 'is created using a card factory', ->
    expect(wolf).toBeDefined()

  it 'has wait, health, dmg, attackAbilities and defendAbilities', ->
    expect(wolf.wait).toBeDefined()
    expect(wolf.health).toBeDefined()
    expect(wolf.dmg).toBeDefined()
    expect(wolf.attackAbilities).toBeDefined()
    expect(wolf.defendAbilities).toBeDefined()

  it 'can attack another card', ->
    expect(soldier.health).toBe cardFactory.cards.soldier.health
    attack wolf, soldier
    expect(soldier.health).toBe cardFactory.cards.soldier.health - 1

  it 'defends when attacked', ->
    spyOn soldier, 'defend'
    attack wolf, soldier
    expect(soldier.defend).toHaveBeenCalled()

  it 'dies when health is 0 or less', ->
    oneHealthCreature = cardFactory.create addCard 1, 1, 1
    expect(oneHealthCreature.isAlive()).toBe true
    attack wolf, oneHealthCreature
    expect(oneHealthCreature.isAlive()).toBe false
