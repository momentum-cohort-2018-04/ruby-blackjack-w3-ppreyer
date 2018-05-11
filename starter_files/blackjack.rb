class Game
  def initialize
  end
  def deal_hand(hand, card_one, card_two)
    hand.push(card_one) 
    hand.push(card_two)
  end
  def display_hand_values(hand)
    hand.map do |array|
      array[1]
    end
  end
  def convert_to_number(hand_ranks)
    sum = 0
    hand_ranks.map do |rank|
      if rank == "A"
        rank = 11
      elsif rank == "J" || rank == "Q" || rank == "K" 
        rank = 10
      else 
        rank.to_i    
      end
    end
  end
  def sum_hand_values(number_hand)
    number_hand.sum
  end
  def run
    puts "Hello and welcome to the game of blackjack! Let's begin."
    bank = Wallet.new
    wallet = bank.wallet
    player = Player.new
    new_wallet = player.make_bet(wallet)
    puts "You have $#{new_wallet} and bet $10."
    deck = Deck.new
    new_hand = Hand.new
    hand = new_hand.hand
    random_card_one = deck.pick_random_card
    random_card_two = deck.pick_random_card
    player_hand = self.deal_hand(hand, random_card_one, random_card_two)
    ranks = self.display_hand_values(player_hand)
    values = self.convert_to_number(ranks)
    total = self.sum_hand_values(values)
    puts "You have a #{ranks[0]} and a #{ranks[1]} in your hand. Your total is #{total}."
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

class Wallet
  attr_accessor :wallet
  def initialize
    @wallet = 100
  end
end

class Player
  def initialize
  end
  def make_bet(wallet)
    wallet - 10
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



