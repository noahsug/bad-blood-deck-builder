##
# A target is something that has health and can be attacked.
##
class Target extends EventEmitter

  constructor: (@initHealth) ->
    super()
    @health = @initHealth
    @initializeEffects()

  initializeEffects: ->
    @effects = {}
    @effects.dmgModifier = 0

  isAlive: ->
    @health > 0

  onAttacked: (card, dmg) ->
    @emit 'attacked', card
    @takeDmg dmg

  takeDmg: (dmg) ->
    @health -= dmg

window.Target = Target