class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '
    <div class="card-container">
      <div class="front">
        <img src="img/cards/<%= rankName %>-<%= suitName %>.png" />
      </div>
      <div class="back">
        <img src="img/card-back.png" />
      </div>
    </div>
    '

  initialize: ->
    @render()
    @model.on('change:revealed', @flipCard, @)

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el
      .css
        'position': 'relative'
        'left': '-1000px'
      .animate
        'left': '0px'
        , 500
    if @model.get('revealed')
      setTimeout(@flipCard.bind(@), 600)

  flipCard: ->
    @$el.find('.card-container').addClass('flipper')
