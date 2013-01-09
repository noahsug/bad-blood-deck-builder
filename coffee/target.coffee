##
# A target is something that has health and can be attacked.
##
class Target

  constructor: (@initHealth) ->
    @health = @initHealth

  isAlive: ->
    @health > 0

  defend: ->

window.Target = Target