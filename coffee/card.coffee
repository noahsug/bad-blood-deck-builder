class Card extends Target

  constructor: (initHealth, @initDmg, @initWait) ->
    super initHealth
    @dmg = @initDmg
    @wait = @initWait
    @abilities = []
    @position = undefined
    @owner = undefined
    @opponent = undefined
    @initializeEffects()

  initializeEffects: ->
    @effects = {}
    @effects.dmgModifier = 0

  addAbility: (ability) ->
    ability.setCard this
    @abilities.push ability

  attack: ->
    @emit 'preattack'
    if @getDmg() > 0
      @emit 'attack'

  getDmg: ->
    @dmg += @effects.dmgModifier

  getState: ->
    "#{@dmg}/#{@health}/#{@wait}"

  toString: ->
    @name

window.Card = Card
