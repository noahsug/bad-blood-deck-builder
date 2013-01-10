exports = window.ability ?= {}
exportClass = (ability) ->
  exports[ability.name] = ability

class Ability
  setCard: (@card) ->
    @card.on 'attack', => @onAttack() if @onAttack
    @card.on 'preattack', => @onPreattack() if @onPreattack
    @card.on 'die', => @onDie() if @onDie
    @card.on 'spawn', => @addOwnerListeners(); @onSpawn?()

  target: ->
    @card.owner.opponent.getTargetAt @card.position

  randomTarget: ->
    alive = []
    for card in @card.owner.opponent.field
      alive.push card
    getRandomElement alive

  addOwnerListeners: ->
    @card.owner.on 'turn_start', => (@onTurnStart() if @card.isAlive()) if @onTurnStart
    @card.owner.on 'turn_end', => (@onTurnEnd() if @card.isAlive()) if @onTurnEnd

class Damage extends Ability
  onAttack: ->
    @target().onAttacked @card, @card.dmg
exportClass Damage

class Sap extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    @target().dmg -= @amount
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

class Heal extends Ability
  constructor: (@amount=1) ->

  onPreattack: ->
    lowestHp = undefined
    for card in @card.owner.field
      continue if not card.isAlive() or card.health is card.initHealth
      lowestHp = card if not lowestHp or card.health < lowestHp.health
    lowestHp?.heal @amount
exportClass Heal

class Poison extends Ability
  constructor: (@amount=1) ->

  onAttack: ->
    target = @target()
    target.once 'postattack', =>
      target.takeDmg @amount if target.isAlive()
exportClass Poison

class AdjacentAttackBoost extends Ability
  constructor: (@amount=1) ->
    @left = @right = undefined

  onTurnStart: ->
    @debuff()
    @left = @card.owner.field[@card.position-1]
    @right = @card.owner.field[@card.position+1]
    @left?.dmg += @amount
    @right?.dmg += @amount

  onDie: ->
    @debuff()

  debuff: ->
    @left?.dmg -= @amount
    @right?.dmg -= @amount

exportClass AdjacentAttackBoost