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
    @effects.skipAction = false

  isAlive: ->
    @health > 0

  onAttacked: (card, dmg) ->
    @emit 'attacked', card
    @takeDmg dmg

  takeDmg: (amount) ->
    @health -= amount

  heal: (amount) ->
    @health += amount
    @health = @initHealth if @health > @initHealth

window.Target = Target