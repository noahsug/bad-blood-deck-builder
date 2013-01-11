class DeckBuilder

  NUM_TRIALS: 7500

  constructor: ->
    @log = getLogger this
    @opponentDecks = []

  addOpponentDeck: (opponentCards...) ->
    @opponentDecks.push opponentCards.sort()

  setDeckSize: (@deckSize) ->

  setPlayerHealth: (@playerHealth) ->

  setPlayerCards: (@playerCards...) ->
    @playerCards.sort()

  printResults: (decks) ->
    for i in [decks.length - 1..0]
      playerDeck = decks[i]
      @log "##{i+1} wins #{Math.round(playerDeck.totalScore)}% #{playerDeck}"
      for opponentDeck in @opponentDecks
        @log '  ', Math.round(playerDeck.scoreMap[opponentDeck]) + '%', 'vs', opponentDeck.toString()

  getBestDecks: ->
    playerDecks = @getPossibleDecks()
    for playerDeck in playerDecks
      playerDeck.totalScore = 0
      playerDeck.scoreMap = {}
      @log 'Intermediate scores for', playerDeck.toString()
      for opponentDeck in @opponentDecks
        score = @scoreDeck playerDeck, opponentDeck
        @log score, 'vs', opponentDeck.toString()
        playerDeck.scoreMap[opponentDeck] = score
        playerDeck.totalScore += score
      playerDeck.totalScore /= @opponentDecks.length
      @log ''
    bestDecks = playerDecks.sort (a, b) -> b.totalScore - a.totalScore
    @printResults bestDecks
    bestDecks

  scoreDeck: (playerDeck, opponentDeck) ->
    wins = 0
    for i in [1..@NUM_TRIALS]
      verbose.push 'Game' if i is 1 and 'DeckBuilder' in verbose
      verbose.pop() if i is 2 and 'DeckBuilder' in verbose
      game = @createGame playerDeck, opponentDeck
      wins++ if game.run()
    wins * 100 / @NUM_TRIALS

  createGame: (playerDeck, opponentDeck) ->
    game = new Game()
    player = new Player @playerHealth
    player.setCards playerDeck...
    opponent = new Player @playerHealth
    opponent.setCards opponentDeck...
    game.setPlayers player, opponent
    game

  getPossibleDecks: ->
    uniqueDecks = {}
    @forEachDeckCombination (cardIndexes) =>
      deck = (@playerCards[i] for i in cardIndexes)
      uniqueDecks[deck.sort()] = deck
    possibleDecks = (deck for id, deck of uniqueDecks)
    @log possibleDecks.length, 'possible decks found'
    @log ''
    possibleDecks

  forEachDeckCombination: (callback, position=0, indexes=new Array(@deckSize)) ->
    start = if position is 0 then 0 else indexes[position-1] + 1
    for i in [start..@playerCards.length-1]
      indexes[position] = i
      if position is @deckSize - 1
        callback indexes
      else if i < @playerCards.length - 1
        @forEachDeckCombination callback, position + 1, indexes
    return true

window.DeckBuilder = DeckBuilder
