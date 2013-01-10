exports = window.ability ?= {}
exportClass = (ability) ->
  exports[ability.name] = ability

class Ability
  setCard: (@card) ->
    @card.on 'attack', => @onAttack?()

  target: ->
    @card.owner.opponent.getTargetAt @card.position

  randomTarget: ->
    alive = []
    for card in @card.owner.opponent.field
      alive.push card
    getRandomElement alive

class Damage extends Ability
  onAttack: ->
    @target().onAttacked @card, @card.getDmg()
exportClass Damage

class Sap extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    @target().effects.dmgModifier -= @amount
exportClass Sap

class Trap extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    if Math.random() < .75
      @randomTarget()?.effects.skipAction = true
exportClass Trap

class PayLife extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    @card.health -= @amount
exportClass PayLife
