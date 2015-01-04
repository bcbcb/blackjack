class window.AppView extends Backbone.View
  template: _.template '
    <div class="buttons-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  buttonsTemplate: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
  '

  gameOverTemplate: _.template '
    <button class="new-game">New Game</button> <span class="winnerMessage"><%= winnerMessage %></span>
  '
  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .new-game': ->
      @renderNewGame()

  renderNewGame: ->
    @model.newGame()
    @render()
    @model.get('game').on('change:winner'
     ->
      setTimeout =>
          @$('.buttons-container').html( @gameOverTemplate(@model.get('game').attributes) )
        , 1200
     @)

  initialize: ->
    @renderNewGame()

  render: ->
    @$el.children().detach()
    @$el.html @template
    @$('.buttons-container').html @buttonsTemplate
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get('playerHand')).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get('dealerHand')).el

