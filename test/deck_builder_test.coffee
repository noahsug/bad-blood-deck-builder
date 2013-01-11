describe 'A deck builder', ->
  builder = undefined

  beforeEach ->
    builder = new DeckBuilder()
    builder.setDeckSize 6
    builder.NUM_TRIALS = 500

  it "6 1/2/2's is the best deck out of a card pool of 1/2/2's and 1/1/2's", ->
    strongCard = addCard 1, 2, 2
    weakCard = addCard 1, 1, 2
    strongDeck = (strongCard for i in [1..6])
    weakDeck = (weakCard for i in [1..6])

    builder.setPlayerCards strongDeck..., weakDeck...
    builder.addOpponentDeck strongDeck...
    builder.addOpponentDeck strongDeck[0..2]..., weakDeck[0..2]...

    decks = builder.getBestDecks()
    expect(decks[0].sort().toString()).toBe strongDeck.sort().toString()
