# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @shuffleDeck()

  shuffleDeck: ->
    console.log 'shuffling'
    @set 'deck', deck = new Deck()

  newGame: ->
    if @get('deck').length < 13
      @shuffleDeck()
    @set 'game', game = new Game(@get 'deck')
    console.log( @get('deck').length + 'cards left' )
