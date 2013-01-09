exports = window.ability ?= {}
exportClass = (ability) ->
  exports[ability.name] = ability

class Ability
  setCard: (@card) ->

  actOn: (target) ->

class Damage extends Ability
  actOn: (target) ->
    target.health -= @card.dmg
exportClass Damage
