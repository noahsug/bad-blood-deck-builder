exports = window

exports.addCard = (dmg, health, wait, getAbilities) ->
  getAbilities ?= -> [new ability.Damage()]
  name = "#{dmg}/#{health}/#{wait}"
  cardFactory.cards[name] = { dmg, health, wait, getAbilities }
  name
