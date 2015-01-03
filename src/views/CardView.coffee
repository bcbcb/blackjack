class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png" />'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    if not @model.get 'revealed'
        @$el.html '<img src="img/card-back.png" />'
    else @$el.html @template @model.attributes
    # @$el.addClass 'covered' unless @model.get 'revealed'

