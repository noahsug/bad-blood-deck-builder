class Game

  constructor: ->
    @players = undefined
    @turn = 0

  setPlayers: (player, opponent) ->
    player.name = 'Player'
    opponent.name = 'Opponent'
    player.setOpponent opponent
    opponent.setOpponent player
    @players = [player, opponent]

  getFirstTurnOffset: ->
    if flipCoin() then 0 else 1

  run: ->
    @firstTurnOffset = @getFirstTurnOffset()
    while @players[0].isAlive() and @players[1].isAlive() and not @isTie()
      attacker = @players[(@turn + @firstTurnOffset) % 2]
      defender = @players[(@turn + @firstTurnOffset + 1) % 2]
      @takeTurn attacker, defender
    console.warn 'ITS A TIE!!!!', @turn if @isTie()
    @players[0].isAlive() and not @isTie()

  takeTurn: (attacker, defender) ->
    attacker.reduceWait()
    defender.reduceWait()
    attacker.drawCard()
    attacker.attack()
    attacker.removeDead()
    defender.removeDead()
    @turn++
#    @printState()

  isTie: ->
    @turn > 100

  printState: ->
    attacker = @players[(@turn + @firstTurnOffset) % 2]
    console.log "-------------------- TURN #{@turn} - #{attacker.name} --------------------"
    console.log "# Player"
    @players[0].printState()
    console.log "# Opponent"
    @players[1].printState()
    console.log ''

window.Game = Game
