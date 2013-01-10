class Card extends Target

  constructor: (initHealth, @initDmg, @initWait) ->
    super initHealth
    @dmg = @initDmg
    @wait = @initWait
    @abilities = []
    @position = undefined
    @owner = undefined
    @opponent = undefined

  addAbility: (ability) ->
    ability.setCard this
    @abilities.push ability

  spawnAt: (@position) ->
    @emit 'spawn'

  attack: ->
    @emit 'preattack'
    if @dmg > 0 and not @effects.skipAction
      @emit 'attack'
    @emit 'postattack'

  getState: ->
    "#{@dmg}/#{@health}/#{@wait}"

  toString: ->
    @name

window.Card = Card
