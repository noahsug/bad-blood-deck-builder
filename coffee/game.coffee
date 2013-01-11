class Game

  constructor: ->
    @log = getLogger this
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
    @log @getReadableState()

  isTie: ->
    @turn > 100

  getReadableState: ->
    attacker = @players[(@turn + @firstTurnOffset) % 2]
    msg = "-------------------- TURN #{@turn} - #{attacker.name} --------------------\n"
    msg += "# Player\n"
    msg += @players[0].getReadableState() + '\n'
    msg += "# Opponent\n"
    msg += @players[1].getReadableState() + '\n\n'

window.Game = Game
