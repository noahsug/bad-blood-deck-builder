class CardFactory
  create: (name) ->
    throw "card #{name} not found" unless name of @cards
    stats = @cards[name]
    card = new Card stats.health, stats.dmg, stats.wait
    card.name = name
    for attackAbility in stats.attackAbilities ? []
      card.addAttackAbility attackAbility
    for defendAbility in stats.defendAbilities ? []
      card.addDefendAbility defendAbility
    return card

  cards:

    wolf:
      wait: 2
      health: 4
      dmg: 1
      attackAbilities: [ new ability.Damage() ]

    soldier:
      wait: 2
      health: 5
      dmg: 1
      attackAbilities: [ new ability.Damage() ]

window.cardFactory = new CardFactory()
