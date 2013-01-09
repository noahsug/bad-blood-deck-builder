describe 'A deck builder', ->

  it 'test', ->
    builder = new DeckBuilder()
    builder.setPlayerCards 'soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'wolf', 'wolf', 'wolf', 'wolf'

    builder.addOpponentDeck 'wolf', 'wolf', 'wolf', 'wolf', 'wolf', 'wolf'
    builder.addOpponentDeck 'soldier', 'soldier', 'soldier', 'wolf', 'wolf', 'wolf'
    builder.addOpponentDeck 'soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'soldier'

    builder.printResults()