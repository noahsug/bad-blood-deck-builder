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
        card.spawnAt @field.length - 1
      else
        newWaiting.push card
    @waiting = newWaiting
    @emit 'turn_start'

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
    @emit 'turn_end'

  isAlive: ->
    super() and (@field.length > 0 or @deck.length > 0 or @waiting.length > 0)

  getReadableState: ->
    msg = "Health: #{@health}, Deck: #{@deck.length}, Waiting: #{@waiting.length}\n"
    msg += ("[ #{card.getState()} ]" for card in @field).join ' '

  toString: ->
    @id

window.Player = Player
