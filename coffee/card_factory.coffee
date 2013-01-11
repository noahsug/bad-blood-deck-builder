class CardFactory
  create: (name) ->
    throw "card #{name} not found" unless name of @cards
    stats = @cards[name]
    card = new Card stats.health, stats.dmg, stats.wait
    card.name = name
    for ability in stats.getAbilities() ? []
      card.addAbility ability
    card.addAbility new window.ability.Damage()
    return card

  cards:

    'Junior Cleric':
      wait: 8
      dmg: 1
      health: 4
      getAbilities: -> [ new ability.Heal(2) ]

    'Catcher':
      wait: 10
      dmg: 2
      health: 3
      getAbilities: -> [ new ability.Trap() ]

    'Exorcist':
      wait: 6
      dmg: 2
      health: 3
      getAbilities: -> []

    'Residents':
      wait: 2
      dmg: 1
      health: 5
      getAbilities: -> []

    'Skilled Soldier':
      wait: 2
      dmg: 1
      health: 5
      getAbilities: -> []

    'Scientist':
      wait: 2
      dmg: 1
      health: 3
      getAbilities: -> [ new ability.Poison(2) ]

    'Ranger':
      wait: 6
      dmg: 2
      health: 4
      getAbilities: -> []

    'Skilled Hunter':
      wait: 6
      dmg: 1
      health: 4
      getAbilities: -> [ new ability.Sap() ]

    'Juggernaut':
      wait: 6
      dmg: 3
      health: 4
      getAbilities: -> [ new ability.PayLife() ]

    'Werebull':
      wait: 6
      dmg: 1
      health: 3
      getAbilities: -> [new ability.AdjacentAttackBoost()]

    'War Wolves':
      wait: 2
      dmg: 1
      health: 4
      getAbilities: -> []

    'Guard Wolves':
      wait: 4
      dmg: 2
      health: 3
      getAbilities: -> []

window.cardFactory = new CardFactory()