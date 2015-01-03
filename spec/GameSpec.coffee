assert = chai.assert

describe 'winning and losing', ->
  deck = null
  game = null

  ace = new Card(rank: 1, suit: 1)
  king = new Card(rank: 0, suit: 1)
  six = new Card(rank: 6, suit: 1)
  seven = new Card(rank: 7, suit: 1)

  beforeEach ->
    deck = new Deck()
    game = new Game(deck)

  describe 'busting', ->
    it 'should be true for > 21', ->
      hand = new Hand ([king, king.clone(), king.clone()])
      assert.isTrue game.isBust(hand)
    it 'should be false for < 21', ->
      hand = new Hand ([king, king.clone()])
      assert.isFalse game.isBust(hand)
    it 'should not bust for 2 aces', ->
      hand = new Hand ([ace, ace.clone()])
      assert.isFalse game.isBust(hand)
    it 'should not bust for 3 aces', ->
      hand = new Hand ([ace, ace.clone(), ace.clone()])
      assert.isFalse game.isBust(hand)
    it 'should not bust on 21', ->
      hand = new Hand ([ace, king])
      assert.isFalse game.isBust(hand)



  describe 'player', ->
    it 'should lose on bust', ->
      game.set('playerHand', new Hand ([king, king.clone(), king.clone()]))
      game.checkPlayersHand()
      assert.strictEqual game.get('winner'), 'dealer'
    it 'should win when score is greater than dealer and less than or equal to 21', ->
      game.set('playerHand', new Hand ([king, ace]))
      game.set('dealerHand', new Hand ([king, king.clone()]))
      game.get('dealerHand').at(0).flip()
      game.checkPlayersHand()
      game.compareHands()
      assert.strictEqual game.get('winner'), 'player'

  describe 'dealer', ->
    it 'should lose on bust', ->
      game.set('dealerHand', new Hand ([king, king.clone(), king.clone()]))
      game.get('dealerHand').at(0).flip()
      game.compareHands()
      assert.strictEqual game.get('winner'), 'player'

    it 'should hit when score is less than 17', ->
      game.set('dealerHand', new Hand [ace, ace.clone()], deck)
      game.get('dealerHand').at(0).flip()
      game.compareHands()
      assert.notEqual game.get('dealerHand').length, 2

    it 'should stay when score is 17', ->
      game.set('dealerHand', new Hand [king, seven], deck)
      game.get('dealerHand').at(0).flip()
      game.compareHands()
      assert.strictEqual game.get('dealerHand').length, 2

    it 'should win when score is greater than player and less than or equal to 21', ->
      game.set('playerHand', new Hand ([king, six]))
      game.set('dealerHand', new Hand ([king, seven]))
      game.get('dealerHand').at(0).flip()
      game.checkPlayersHand()
      game.compareHands()
      assert.strictEqual game.get('winner'), 'dealer'

  describe 'push', ->
    it 'should happen when dealer and player have the same score', ->
      game.set('playerHand', new Hand ([king, ace]))
      game.set('dealerHand', new Hand ([king, ace]))
      game.get('dealerHand').at(0).flip()
      game.checkPlayersHand()
      game.compareHands()
      assert.strictEqual game.get('winner'), 'tie'

