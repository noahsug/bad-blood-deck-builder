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
    @effects.skipAction = false

  isAlive: ->
    @health > 0

  onAttacked: (card, dmg) ->
    @emit 'attacked', card
    @takeDmg dmg

  takeDmg: (amount) ->
    @health -= amount
    @die() if @health <= 0

  heal: (amount) ->
    @health += amount
    @health = @initHealth if @health > @initHealth

  die: ->
    @emit 'die'

window.Target = Target