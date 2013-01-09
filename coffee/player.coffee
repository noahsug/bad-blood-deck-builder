class Player extends Target

  constructor: (initHealth) ->
    super initHealth
    @field = []
    @waiting = []
    @deck = []

  setCards: (cardNames...) ->
    @deck = shuffle (cardFactory.create name for name in cardNames)
    @id = (name for name in cardNames).join ', '

  reduceWait: ->
    newWaiting = []
    for card in @waiting
      card.wait -= 1
      if card.wait <= 0
        @field.push card
      else
        newWaiting.push card
    @waiting = newWaiting

  drawCard: ->
    if @deck.length > 0
      @waiting.push @deck.pop()

  attack: (opponent) ->
    for card, i in @field
      card.attack opponent, i

  getTargetAt: (index) ->
    if @field.length > index and @field[index].isAlive()
      @field[index]
    else
      this

  removeDead: ->
    newField = []
    for card in @field
      newField.push card if card.isAlive()
    @field = newField

  isAlive: ->
    super() and (@field.length > 0 or @deck.length > 0 or @waiting.length > 0)

  printState: ->
    console.log "Health: #{@health}, Deck: #{@deck.length}, Waiting: #{@waiting.length}"
    console.log ("[ #{card.getState()} ]" for card in @field).join ' '

  toString: ->
    @id

window.Player = Player
