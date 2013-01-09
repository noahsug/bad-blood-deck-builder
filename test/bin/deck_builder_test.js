(function() {

  describe('A deck builder', function() {
    return it('test', function() {
      var builder;
      builder = new DeckBuilder();
      builder.setPlayerCards('soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'wolf', 'wolf', 'wolf', 'wolf');
      builder.addOpponentDeck('wolf', 'wolf', 'wolf', 'wolf', 'wolf', 'wolf');
      builder.addOpponentDeck('soldier', 'soldier', 'soldier', 'wolf', 'wolf', 'wolf');
      builder.addOpponentDeck('soldier', 'soldier', 'soldier', 'soldier', 'soldier', 'soldier');
      return builder.printResults();
    });
  });

}).call(this);
