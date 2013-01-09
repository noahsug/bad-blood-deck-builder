describe 'A game', ->
  game = player1 = player2 = undefined

  createGame = ->
    player1 = new Player 20
    player2 = new Player 20
    game = new Game()
    game.setPlayers player1, player2

  it 'has a winner', ->
    createGame()
    player1.setCards 'wolf'
    player2.setCards 'wolf'

    expect(game.run()).toBeDefined()

  it '1/2/2 always beats 1/1/2', ->
    for i in [1..5]
      createGame()
      player1.setCards addCard 1, 2, 2
      player2.setCards addCard 1, 1, 2

      expect(game.run()).toBe true

  it "3 1/2/2's always beat 3 1/1/2's", ->
    for i in [1..5]
      createGame()
      player1.setCards addCard(1, 2, 2), addCard(1, 2, 2), addCard(1, 2, 2)
      player2.setCards addCard(1, 1, 2), addCard(1, 1, 2), addCard(1, 1, 2)

      expect(game.run()).toBe true

  it '1/1/2 sometimes beats 1/1/2', ->
    won = false
    lost = false
    for i in [0..10]
      createGame()
      player1.setCards addCard 1, 1, 2
      player2.setCards addCard 1, 1, 2

      if game.run()
        won = true
      else
        lost = true
    expect(won and lost).toBe true

  it "3 1/5/2's sometimes beats 3 1/5/2's", ->
    won = false
    lost = false
    for i in [0..10]
      createGame()
      player1.setCards addCard 1, 1, 2
      player2.setCards addCard 1, 1, 2

      if game.run()
        won = true
      else
        lost = true
    expect(won and lost).toBe true

  it '1/1/2 always loses to 1/1/4', ->
    for i in [1..5]
      createGame()
      player1.setCards addCard 1, 1, 2
      player2.setCards addCard 1, 1, 4

      expect(game.run()).toBe false
