class Game

  constructor: ->
    @players = undefined
    @turn = 0

  setPlayers: (player, opponent) ->
    player.name = 'Player'
    opponent.name = 'Opponent'
    @players = [player, opponent]

  run: ->
    firstTurnOffset = if flipCoin() then 0 else 1
    while @players[0].isAlive() and @players[1].isAlive() and not @isTie()
      attacker = @players[(@turn + firstTurnOffset) % 2]
      defender = @players[(@turn + firstTurnOffset + 1) % 2]
      @takeTurn attacker, defender
    console.warn 'ITS A TIE!!!!', @turn if @isTie()
    @players[0].isAlive() and not @isTie()

  takeTurn: (attacker, defender) ->
    attacker.reduceWait()
    defender.reduceWait()
    attacker.drawCard()
    attacker.attack defender
    attacker.removeDead()
    defender.removeDead()
    @turn++
#    @printState attacker

  isTie: ->
    @turn > 100

  printState: (attacker) ->
    console.log "-------------------- TURN #{@turn} - #{attacker.name} --------------------"
    console.log "# Player"
    @players[0].printState()
    console.log "# Opponent"
    @players[1].printState()
    console.log ''

window.Game = Game
