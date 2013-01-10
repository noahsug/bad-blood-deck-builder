describe 'A player', ->
  player = opponent = undefined

  beforeEach ->
    player = new Player 5
    opponent = new Player 5
    opponent.name = 'opponent'
    player.name = 'player'
    player.setOpponent opponent
    opponent.setOpponent player

  summonSlime = ->
    slime = addCard 3, 1, 1
    player.setCards slime
    opponent.setCards slime
    opponent.drawCard()
    player.drawCard()
    player.reduceWait()

  it 'gets a deck of cards with setCards()', ->
    player.setCards 'wolf', 'soldier', 'wolf'
    expect(player.deck.length).toBe 3

  it 'draws a card from the deck into the waiting area with drawCard()', ->
    player.setCards 'wolf', 'soldier'
    expect(player.waiting.length).toBe 0
    player.drawCard()
    expect(player.waiting.length).toBe 1
    expect(player.deck.length).toBe 1

  it 'does nothing trying to draw a card with an empty deck', ->
    player.setCards 'wolf'
    player.drawCard()
    expect(player.waiting.length).toBe 1
    expect(player.deck.length).toBe 0

    player.drawCard()
    expect(player.waiting.length).toBe 1
    expect(player.deck.length).toBe 0

  it 'reduces the wait time of all cards in the waiting area with reduceWait()', ->
    waitingCard = addCard 1, 1, 5
    player.setCards waitingCard, waitingCard, waitingCard
    player.drawCard()
    player.reduceWait()
    player.drawCard()
    player.reduceWait()
    expect(player.waiting[0].wait).toBe 3
    expect(player.waiting[1].wait).toBe 4
    expect(player.deck[0].wait).toBe 5

  it "moves a card from the waiting area to the field when a card's wait reaches 0", ->
    waitingCard = addCard 1, 1, 1
    player.setCards waitingCard
    player.drawCard()
    player.reduceWait()
    expect(player.waiting.length).toBe 0
    expect(player.field.length).toBe 1

  it 'returns the card at the given index in the field with getTargetAt()', ->
    waitingCard = addCard 1, 1, 1
    player.setCards waitingCard
    player.drawCard()
    player.reduceWait()
    expect(player.getTargetAt(0)).toBe player.field[0]

  it 'returns itself if no card exists at the given index', ->
    expect(player.getTargetAt(0)).toBe player

  it 'can attack and kill another player attack()', ->
    summonSlime()
    player.attack()
    expect(opponent.health).toBe 2
    player.attack opponent
    expect(opponent.isAlive()).toBe false

  it 'can attack and kill another card with attack()', ->
    summonSlime()
    opponent.reduceWait()
    player.attack()
    expect(opponent.field[0].isAlive()).toBe false
    expect(opponent.health).toBe 5

  it 'can remove dead cards with removeDead()', ->
    summonSlime()
    opponent.reduceWait()
    player.attack()
    opponent.removeDead()
    expect(opponent.field.length).toBe 0

  it 'is dead when no cards are left in the deck, waiting area and field', ->
    summonSlime()
    opponent.reduceWait()
    player.attack()
    opponent.removeDead()
    expect(opponent.isAlive()).toBe false