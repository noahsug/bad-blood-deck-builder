exports = window.ability ?= {}
exportClass = (ability) ->
  exports[ability.name] = ability

class Ability
  setCard: (@card) ->

  actOn: (@opponent, @position) ->

class Damage extends Ability
  actOn: (opponent, position) ->
    opponent.getTargetAt(position).health -= @card.dmg
exportClass Damage
