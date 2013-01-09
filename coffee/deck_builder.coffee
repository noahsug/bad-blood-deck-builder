class DeckBuilder

  NUM_TRIALS: 10000

  PLAYER_HP: 25

  constructor: ->
    @opponentDecks = []

  addOpponentDeck: (opponentCards...) ->
    @opponentDecks.push opponentCards

  setPlayerCards: (@playerCards...) ->

  printResults: ->
    decks = @getBestDecks()
    for playerDeck, i in decks
      console.log "##{decks.length-i} wins #{Math.round(playerDeck.totalScore)}% #{playerDeck}"
      for opponentDeck in @opponentDecks
        console.log '  ', playerDeck.scoreMap[opponentDeck], 'vs', opponentDeck.toString()

  getBestDecks: ->
    playerDecks = @getPossibleDecks()
    console.log playerDecks.length, 'possible decks found'
    console.log ''
    for playerDeck in playerDecks
      playerDeck.totalScore = 0
      playerDeck.scoreMap = {}
      console.log 'Intermediate scores for', playerDeck.toString()
      for opponentDeck in @opponentDecks
        score = @scoreDeck playerDeck, opponentDeck
        console.log score, 'vs', opponentDeck.toString()
        playerDeck.scoreMap[opponentDeck] = score
        playerDeck.totalScore += score
      playerDeck.totalScore /= @opponentDecks.length
      console.log ''
    playerDecks.sort (a, b) -> a.totalScore - b.totalScore

  scoreDeck: (playerDeck, opponentDeck) ->
    wins = 0
    for i in [1..@NUM_TRIALS]
      game = @createGame playerDeck, opponentDeck
      wins++ if game.run()
    wins * 100 / @NUM_TRIALS

  createGame: (playerDeck, opponentDeck) ->
    game = new Game()
    player = new Player @PLAYER_HP
    player.setCards playerDeck...
    opponent = new Player @PLAYER_HP
    opponent.setCards opponentDeck...
    game.setPlayers player, opponent
    game

  getPossibleDecks: ->
    maxDeckSize = 6
    uniqueDecks = {}
    @forEachDeckCombination (cardIndexes) =>
      deck = (@playerCards[i] for i in cardIndexes)
      uniqueDecks[deck.sort()] = deck
    (deck for id, deck of uniqueDecks)

  forEachDeckCombination: (callback, position=0, indexes=new Array(6)) ->
    start = if position is 0 then 0 else indexes[position-1] + 1
    for i in [start..@playerCards.length-1]
      indexes[position] = i
      if position is 5
        callback indexes
      else if i < @playerCards.length - 1
        @forEachDeckCombination callback, position + 1, indexes
    return true

window.DeckBuilder = DeckBuilder
