# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @shuffleDeck()
    @set 'totalChips', 100

  shuffleDeck: ->
    @set 'deck', deck = new Deck()

  newGame: ->
    console.log(@get 'totalChips')
    if @get('deck').length < 13
      @shuffleDeck()
    @set 'totalChips', (@get 'totalChips') - 10
    @set 'bet', 10
    game = new Game(@get('deck'))
    @set 'game', game
    game.on('change:winner',
      =>
        switch @get('game').get 'winner'
          when 'player' then @set 'totalChips', (@get 'totalChips') + ((@get 'bet') * 2)
          when 'tie' then @set 'totalChips', (@get 'totalChips') + (@get 'bet')
        console.log(@get 'bet')
    )
