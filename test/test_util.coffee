exports = window

exports.addCard = (dmg, health, wait, abilities=[ability.Damage]) ->
  name = "#{dmg}/#{health}/#{wait}"
  cardFactory.cards[name] = { dmg, health, wait, abilities }
  name
