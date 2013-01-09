exports = window

exports.addCard = (dmg, health, wait, attackAbilities=[], defendingAbilities=[]) ->
  attackAbilities.push new ability.Damage()
  name = "#{dmg}/#{health}/#{wait}"
  cardFactory.cards[name] = { dmg, health, wait, attackAbilities,  defendingAbilities }
  name
