exports = window.ability ?= {}
exportClass = (ability) ->
  exports[ability.name] = ability

class Ability
  setCard: (@card) ->
    @card.on 'attack', => @onAttack?()

  target: ->
    @card.owner.opponent.getTargetAt @card.position

class Damage extends Ability
  onAttack: ->
    @target().onAttacked @card, @card.getDmg()
exportClass Damage

class Sap extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    @target().effects.dmgModifier -=1
exportClass Sap

class Trap extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    @target().effects.dmgModifier -=1
exportClass Trap
