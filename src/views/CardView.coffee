class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png" />'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    if not @model.get 'revealed'
        @$el.html '<img src="img/card-back.png" />'
        @model.on('change:revealed', @flipCard, @)
    else
      @$el.html @template @model.attributes
    @$el
      .css
        'position': 'relative'
        'left': '-1000px'
      .animate
        'left': '0px'
        , 500

  flipCard: ->
    @$el.css
      'transform': 'rotateX(720deg)'
      'transition': '1s'
    @$el.html @template @model.attributes
