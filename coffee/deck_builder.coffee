class DeckBuilder

  constructor: ->
    @opponentDecks = []

  addOpponentDeck: (opponentCards...) ->
    @opponentDecks.push opponentCards

  setPlayerCards: (@playerCards...) ->

  printResults: ->
    for playerDeck, i in @getBestDecks()
      console.log "##{i+1} (#{playerDeck.totalScore}) - #{playerDeck}"
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
      console.log ''
    playerDecks.sort (a, b) -> b.totalScore - a.totalScore

  scoreDeck: (playerDeck, opponentDeck) ->
    totalGames = 10000
    wins = 0
    for i in [1..totalGames]
      game = @createGame playerDeck, opponentDeck
      wins++ if game.run()
    (wins * 100) / totalGames

  createGame: (playerDeck, opponentDeck) ->
    game = new Game()
    player = new Player 20
    player.setCards playerDeck...
    opponent = new Player 20
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
