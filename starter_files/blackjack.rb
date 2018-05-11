class Game
  def initialize
  end
  def deal_hand(hand, card_one, card_two)
    hand.push(card_one) 
    hand.push(card_two)
  end
end

class Card
  def initialize
    @suit = suit
    @rank = rank
  end
end

# card = Card.new("Heart", "Q")

class Deck
  attr_accessor :cards
  def initialize
    @ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    @suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    @cards = []
    # @player_hand = []
    
    @suits.map do |suit| 
      @ranks.map do |rank|
        card_array = []
        card_array << suit 
        card_array << rank
        @cards << card_array
      end
    end
  end
  
  def pick_random_card
    @cards.delete(@cards.sample)  
  end

end

class Hand
  attr_accessor :hand
  def initialize
    @hand = []
  end
end

# class Player
#   # hand object
#   # wallet property
#   # hand total property
#   # hit or stay method
#   # calculate total
# end

# class Dealer < Player
#   # hand object
#   # hand total property
#   # hit or stay method
#   # auto compare method
# end



