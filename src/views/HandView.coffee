class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove', @renderCard, @
    @collection.on 'change', @renderScore, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.bestScore()

  renderCard: ->
    @$el.append(new CardView(model: @collection.at(@collection.length-1)).$el )
    @renderScore()

  renderScore: ->
    setTimeout ( =>
      @$('.score').text @collection.bestScore()
      ), 800
