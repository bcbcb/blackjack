class window.Game extends Backbone.Model
  initialize: (deck)->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @checkPlayersHand, @)
    @get('playerHand').on('stand', @compareHands, @)

  isBust: (hand)->
    if hand.minScore() > 21 then true else false

  checkPlayersHand: ->
    if @isBust @get 'playerHand'
      @dealerWins()

  compareHands: ->
    @get 'dealerHand'
      .at 0
      .flip()
    @dealerHit()
    if @isBust @get 'dealerHand'
      @playerWins()
    else if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
      @playerWins()
    else if @get('playerHand').bestScore() == @get('dealerHand').bestScore()
      @tieScore()
    else
      @dealerWins()

  dealerHit: ->
    dealerHand = @get 'dealerHand'
    score1 = dealerHand.scores()[0]
    score2 = dealerHand.scores()[1]
    console.log(score1, score2)
    console.log @get 'dealerHand'
    if score1 < 17 and (score2 < 17 or score2 > 21)
      dealerHand.hit()
      @dealerHit()

  playerWins: ->
    console.log 'player wins'
    @set 'winner', 'player'

  dealerWins: ->
    console.log 'dealer wins'
    @set 'winner', 'dealer'

  tieScore: ->
    console.log 'tie game'
    @set 'winner', 'tie'

