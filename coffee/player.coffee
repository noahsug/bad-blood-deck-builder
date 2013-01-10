class Player extends Target

  constructor: (initHealth) ->
    super initHealth
    @field = []
    @waiting = []
    @deck = []

  setOpponent: (@opponent) ->

  setCards: (cardNames...) ->
    @deck = []
    for name in cardNames
      card = cardFactory.create name
      @deck.push card
      card.owner = this
    shuffle @deck
    @id = (name for name in cardNames).join ', '

  reduceWait: ->
    newWaiting = []
    for card in @waiting
      card.wait -= 1
      if card.wait <= 0
        @field.push card
        card.position = @field.length - 1
      else
        newWaiting.push card
    @waiting = newWaiting

  drawCard: ->
    if @deck.length > 0
      @waiting.push @deck.pop()

  attack: ->
    for card in @field
      card.attack()

  getTargetAt: (index) ->
    if @field.length > index and @field[index].isAlive()
      @field[index]
    else
      this

  removeDead: ->
    newField = []
    for card in @field
      if card.isAlive()
        newField.push card
        card.position = newField.length - 1
    @field = newField

  isAlive: ->
    super() and (@field.length > 0 or @deck.length > 0 or @waiting.length > 0)

  printState: ->
    console.log "Health: #{@health}, Deck: #{@deck.length}, Waiting: #{@waiting.length}"
    console.log ("[ #{card.getState()} ]" for card in @field).join ' '

  toString: ->
    @id

window.Player = Player
