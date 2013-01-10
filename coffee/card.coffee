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

  attack: ->
    return if @effects.skipAction
    @emit 'preattack'
    if @getDmg() > 0
      @emit 'attack'

  getDmg: ->
    @dmg + @effects.dmgModifier

  getState: ->
    "#{@dmg}/#{@health}/#{@wait}"

  toString: ->
    @name

window.Card = Card
