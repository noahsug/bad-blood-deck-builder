class CardFactory
  create: (name) ->
    throw "card #{name} not found" unless name of @cards
    stats = @cards[name]
    card = new Card stats.health, stats.dmg, stats.wait
    card.name = name
    for ability in stats.getAbilities() ? []
      card.addAbility ability
    return card

  cards:

    wolf:
      wait: 2
      health: 4
      dmg: 1
      getAbilities: -> [ new ability.Damage() ]

    soldier:
      wait: 2
      health: 5
      dmg: 1
      getAbilities: -> [ new ability.Damage() ]

window.cardFactory = new CardFactory()
