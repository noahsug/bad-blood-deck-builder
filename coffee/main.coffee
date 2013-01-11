builder = new DeckBuilder()

x = (num, card) ->
  (card for i in [1..num])

builder.setDeckSize 7
builder.setPlayerHealth 20

builder.setPlayerCards 'Junior Cleric', 'Skilled Soldier', 'Scientist', 'Ranger', 'Skilled Hunter', 'Juggernaut', 'Christina',
    'Catcher'

#builder.addOpponentDeck x(3, 'Werebull')..., x(3, 'Guard Wolves')..., 'Jake'
#builder.addOpponentDeck x(3, 'War Wolves')..., x(3, 'Guard Wolves')..., 'Jake'
builder.addOpponentDeck 'Junior Cleric', 'Skilled Soldier', 'Scientist', 'Ranger', 'Skilled Hunter', 'Juggernaut', 'Christina'


decks = builder.getBestDecks()
