exports = window

exports.addCard = (dmg, health, wait, getAbilities=->[]) ->
  name = "#{dmg}/#{health}/#{wait}"
  cardFactory.cards[name] = { dmg, health, wait, getAbilities }
  name
