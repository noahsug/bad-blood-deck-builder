class Card extends Target

  constructor: (initHealth, @initDmg, @initWait) ->
    super initHealth
    @dmg = @initDmg
    @wait = @initWait
    @effects = []
    @attackAbilities = []
    @defendAbilities = []

  addAttackAbility: (ability) ->
    ability.setCard this
    @attackAbilities.push ability

  addDefendAbility: (ability) ->
    ability.setCard this
    @defendAbilities.push ability

  attack: (target) ->
    for ability in @attackAbilities
      ability.actOn target
    target.defend this

  defend: (target) ->
    for ability in @defendAbilities
      ability.actOn target

  getState: ->
    "#{@dmg}/#{@health}/#{@wait}"

  toString: ->
    @name

window.Card = Card
