describe 'A game', ->
  game = player1 = player2 = undefined

  createGame = ->
    player1 = new Player 20
    player2 = new Player 20
    game = new Game()
    game.setPlayers player1, player2

  forEachPlayerGoingFirst = (callback) ->
    createGame()
    playerGoesFirst()
    callback()

    createGame()
    opponentGoesFirst()
    callback()

  playerGoesFirst = ->
    game.getFirstTurnOffset = -> 0

  opponentGoesFirst = ->
    game.getFirstTurnOffset = -> 1

  it 'has a winner', ->
    createGame()
    player1.setCards 'wolf'
    player2.setCards 'wolf'

    expect(game.run()).toBeDefined()

  it '1/2/2 always beats 1/1/2', ->
    forEachPlayerGoingFirst ->
      player1.setCards addCard 1, 2, 2
      player2.setCards addCard 1, 1, 2

      expect(game.run()).toBe true

  it "3 1/2/2's always beat 3 1/1/2's", ->
    forEachPlayerGoingFirst ->
      player1.setCards addCard(1, 2, 2), addCard(1, 2, 2), addCard(1, 2, 2)
      player2.setCards addCard(1, 1, 2), addCard(1, 1, 2), addCard(1, 1, 2)

      expect(game.run()).toBe true

  it '1/1/2 sometimes beats 1/1/2', ->
    won = 0
    forEachPlayerGoingFirst ->
      player1.setCards addCard 1, 1, 2
      player2.setCards addCard 1, 1, 2
      won++ if game.run()
    expect(won).toBe 1

  it "3 1/5/2's sometimes beats 3 1/5/2's", ->
    won = 0
    forEachPlayerGoingFirst ->
      player1.setCards addCard 1, 5, 2
      player2.setCards addCard 1, 5, 2
      won++ if game.run()
    expect(won).toBe 1

  it '1/1/2 always loses to 1/1/4', ->
    forEachPlayerGoingFirst ->
      player1.setCards addCard 1, 1, 2
      player2.setCards addCard 1, 1, 4
      expect(game.run()).toBe false

  it '2/10/2 always loses to 1/4/2 with sap', ->
    forEachPlayerGoingFirst ->
      player1.setCards addCard 2, 10, 2
      player2.setCards addCard 1, 4, 2, -> [new ability.Damage(), new ability.Sap()]
      expect(game.run()).toBe false

  it '1/2/2 with trap can sometimes beat a 10/2/2', ->
    won = 0
    for i in [1..4]
      createGame()
      opponentGoesFirst()
      player1.setCards addCard 1, 2, 2, -> [new ability.Damage(), new ability.Trap()]
      player2.setCards addCard 10, 2, 2
      won++ if game.run()
    expect(won > 0).toBe true

  it '1/10/2 sometimes beats a 1/20/2 with pay life', ->
    won = 0
    forEachPlayerGoingFirst ->
      player1.setCards addCard 1, 10, 2
      player2.setCards addCard 1, 20, 2, -> [new ability.Damage(), new ability.PayLife()]
      won++ if game.run()
    expect(won).toBe 1

  it '5/20/2 never beats a 1/6/2 with heal 5', ->
    won = 0
    forEachPlayerGoingFirst ->
      player1.setCards addCard 5, 20, 2
      player2.setCards addCard 1, 6, 2, -> [new ability.Damage(), new ability.Heal(5)]
      won++ if game.run()
    expect(won).toBe 0

  it '2/10/2 sometimes beats a 1/7/2 with poison 2', ->
    won = 0
    forEachPlayerGoingFirst ->
      player1.setCards addCard 2, 10, 2
      player2.setCards addCard 1, 7, 2, -> [new ability.Damage(), new ability.Poison(2)]
      won++ if game.run()
    expect(won).toBe 1
