class window.Game extends Backbone.Model
  initialize: (deck)->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @checkPlayersHand, @)
    @get('playerHand').on('stand', @compareHands, @)

  isBust: (hand)->
    if hand.minScore() > 21
      true

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
    else if @bestScore(@get('playerHand')) > @bestScore(@get('dealerHand'))
      @playerWins()
    else if @bestScore(@get('playerHand')) == @bestScore(@get('dealerHand'))
      @tieScore()
    else
      @dealerWins()

  dealerHit: ->
    dealerHand = @get 'dealerHand'
    score1 = dealerHand.scores()[0]
    score2 = dealerHand.scores()[1]
    if score1 < 16 and (score2 < 16 or score2 > 21)
      dealerHand.hit()
      @dealerHit()

  bestScore: (hand)->
     if hand.scores()[1] > 21 then hand.scores()[0] else hand.scores()[1]

  playerWins: ->
    console.log 'player wins'

  dealerWins: ->
    console.log 'dealer wins'

  tieScore: ->
    console.log 'tie game'

    # RULES
    # reveal dealer's card
    # if dealer's score < 17, dealer hits
    # if dealers score > 21 or < players score, dealer loses / player wins
    # else dealer wins
