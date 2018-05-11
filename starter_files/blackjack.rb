class Game
  # turn property
  # winner property
  # start game
  # take turn
  # reset round
  # compare hands method
end

class Card
  def initialize
    @suit = suit
    @rank = rank
  end
end

class Deck
  attr_accessor :cards
  def initialize
    @ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    @suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    @cards = []
    
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

class Player
  # hand object
  # wallet property
  # hand total property
  # hit or stay method
  # calculate total
end

class Dealer < Player
  # hand object
  # hand total property
  # hit or stay method
  # auto compare method
end



