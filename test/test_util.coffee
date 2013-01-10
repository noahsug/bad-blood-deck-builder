exports = window

exports.addCard = (dmg, health, wait, abilities...) ->
  abilities = [ability.Damage] if abilities.length is 0
  name = "#{dmg}/#{health}/#{wait}"
  cardFactory.cards[name] = { dmg, health, wait, abilities }
  name
