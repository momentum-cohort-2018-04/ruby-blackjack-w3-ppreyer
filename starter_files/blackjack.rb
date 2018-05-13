class Game
  attr_accessor :total
  attr_accessor :turn
  def initialize
    @total = 0
    @dealer_total = 0
    @turn = "player"
    @result = ""
  end
  def deal_hand(hand, card_one, card_two)
    hand.push(card_one) 
    hand.push(card_two)
  end
  def deal_card(hand, new_card)
    hand << new_card
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
    if @turn == "player"
      @total = number_hand.sum
    else 
      @dealer_total = number_hand.sum
    end
  end
  def check_hand_length(hand_ranks) 
    if hand_ranks.length == 2
      puts "You have a #{hand_ranks[0]} and a #{hand_ranks[1]} in your hand. Your total is #{@total}."
    elsif hand_ranks.length == 3
      puts "You have a #{hand_ranks[0]}, #{hand_ranks[1]} and a #{hand_ranks[2]} in your hand. Your total is #{@total}."
    elsif hand_ranks.length == 4
      puts "You have a #{hand_ranks[0]}, #{hand_ranks[1]}, #{hand_ranks[2]} and a #{hand_ranks[3]} in your hand. Your total is #{@total}."
    elsif hand_ranks == 5
      puts "You have a #{hand_ranks[0]}, #{hand_ranks[1]}, #{hand_ranks[2]},  #{hand_ranks[3]}  and a #{hand_ranks[4]} in your hand. Your total is #{@total}."
    else
      puts "You have a lot of cards in your hand and your current total is #{total}"
    end
  end
  def check_dealer_hand(hand)
    if @dealer_total > 21 && hand.include?("A")
      @total = @total - 10
    elsif @dealer_total > 21
      puts "The dealer has #{@dealer_total} and busts."
      @result = "win"
    elsif
      @dealer_total >= 17 && @dealer_total <= 21
      puts "The dealer stays and has #{@dealer_total}."
      compare_hands
    else
      puts @dealer_total     
      puts "The dealer will hit."
    end
  end
  def check_total_against_21(hand_ranks)
    if @total > 21 && hand_ranks.include?("A")
      @total = @total - 10
      if @total > 21
        puts "You busted! Would you like to play another round?"
        @result = "win"
      abort
      end
    elsif @total > 21
      self.check_hand_length(hand_ranks)
      puts "You busted! Would you like to play another round?"
      abort
    end
  end
  def compare_hands
    if @total == @dealer_total
      puts "It's a push."
      @result = "tie"
    elsif @total > @dealer_total
      puts "Congrats you won!"
      @result = "win"
    else
      puts "Sorry, the dealer has you beat." 
      @result = "loss"
    end
  end
  def add_won_bet_to_wallet(result, wallet)
    if result == "win" 
      wallet = wallet + 20
      puts "You now have $#{wallet} available to bet."
      abort
    elsif result == "tie" 
      wallet = wallet + 10
      puts "You now have $#{wallet} available to bet"
      abort
    elsif result == "loss"
      puts "You now have $#{wallet} available to bet"
      abort
    else 
      puts "onwards"
    end
  end
  def run
    puts "Hello and welcome to the game of blackjack! Let's begin."
    bank = Wallet.new
    old_wallet = bank.wallet
    player = Player.new
    new_wallet = player.make_bet(old_wallet)
    puts "You bet $10 and now have $#{new_wallet} worth of chips."
    deck = Deck.new
    new_hand = Hand.new
    hand = new_hand.hand
    random_card_one = deck.pick_random_card
    random_card_two = deck.pick_random_card
    player_hand = deal_hand(hand, random_card_one, random_card_two)
    ranks = display_hand_values(player_hand)
    values = convert_to_number(ranks)
    total = sum_hand_values(values)
    check_total_against_21(ranks)
    check_hand_length(ranks)
    decision = player.hit_or_stay
    if decision
      deal_card(player_hand, deck.pick_random_card)
      ranks = display_hand_values(player_hand)
      values = convert_to_number(ranks)
      total = sum_hand_values(values)
      check_total_against_21(ranks)
      check_hand_length(ranks)
      decision = player.hit_or_stay
        if decision
          deal_card(player_hand, deck.pick_random_card)
          ranks = display_hand_values(player_hand)
          values = convert_to_number(ranks)
          total = sum_hand_values(values)
          check_total_against_21(ranks)
          check_hand_length(ranks)
          decision = player.hit_or_stay
          if decision
            deal_card(player_hand, deck.pick_random_card)
            ranks = display_hand_values(player_hand)
            values = convert_to_number(ranks)
            total = sum_hand_values(values)
            check_total_against_21(ranks)
            check_hand_length(ranks)
            decision = player.hit_or_stay
          else
            @turn = "dealer"
            puts "You stay. Your total is #{@total}"
            puts "here 1"
            dealer = Dealer.new
            another_hand = Hand.new
            d_hand = another_hand.hand
            card_one = deck.pick_random_card
            card_two = deck.pick_random_card
            dealer_hand = deal_hand(d_hand, card_one, card_two)
            puts "dealer turn"
            d_ranks = display_hand_values(dealer_hand)
            d_values = convert_to_number(d_ranks)
            d_total = sum_hand_values(d_values)
            puts @dealer_total
            check_dealer_hand(d_ranks)
            add_won_bet_to_wallet(@result, new_wallet)
            if @dealer_total < 17
              puts "here here"
            deal_card(dealer_hand, deck.pick_random_card)
            d_ranks = display_hand_values(dealer_hand)
            d_values = convert_to_number(d_ranks)
            d_total = sum_hand_values(d_values)
            puts @dealer_total
            check_dealer_hand(d_ranks)
            add_won_bet_to_wallet(@result, new_wallet)
            puts @dealer_total
            if @dealer_total < 17
              puts "here 2"
              deal_card(dealer_hand, deck.pick_random_card)
              d_ranks = display_hand_values(dealer_hand)
              d_values = convert_to_number(d_ranks)
              d_total = sum_hand_values(d_values)
              puts @dealer_total
              check_dealer_hand(d_ranks)
              add_won_bet_to_wallet(@result, new_wallet)
              puts @dealer_total
              if @dealer_total < 17
                puts "here hello"
                deal_card(dealer_hand, deck.pick_random_card)
                d_ranks = display_hand_values(dealer_hand)
                d_values = convert_to_number(d_ranks)
                d_total = sum_hand_values(d_values)
                puts @dealer_total
                check_dealer_hand(d_ranks)
                add_won_bet_to_wallet(@result, new_wallet)
                puts @dealer_total
                if @dealer_total < 17
                  puts "here 3"
                  deal_card(dealer_hand, deck.pick_random_card)
                  d_ranks = display_hand_values(dealer_hand)
                  d_values = convert_to_number(d_ranks)
                  d_total = sum_hand_values(d_values)
                  puts @dealer_total
                  check_dealer_hand(d_ranks)
                  add_won_bet_to_wallet(@result, new_wallet)
                  puts @dealer_total
                end
              end
            end
          end
          end
        else
          @turn = "dealer"
          puts "You stay. Your total is #{@total}"
          puts "here 4"
          dealer = Dealer.new
          another_hand = Hand.new
          d_hand = another_hand.hand
          card_one = deck.pick_random_card
          card_two = deck.pick_random_card
          dealer_hand = deal_hand(d_hand, card_one, card_two)
          d_ranks = display_hand_values(dealer_hand)
          d_values = convert_to_number(d_ranks)
          d_total = sum_hand_values(d_values)
          check_dealer_hand(d_ranks)
          add_won_bet_to_wallet(@result, new_wallet)
          if @dealer_total < 17
            puts "here here"
          deal_card(dealer_hand, deck.pick_random_card)
          d_ranks = display_hand_values(dealer_hand)
          d_values = convert_to_number(d_ranks)
          d_total = sum_hand_values(d_values)
          check_dealer_hand(d_ranks)
          add_won_bet_to_wallet(@result, new_wallet)
          puts @dealer_total
          if @dealer_total < 17
            puts "here 5"
            deal_card(dealer_hand, deck.pick_random_card)
            d_ranks = display_hand_values(dealer_hand)
            d_values = convert_to_number(d_ranks)
            d_total = sum_hand_values(d_values)
            check_dealer_hand(d_ranks)
            add_won_bet_to_wallet(@result, new_wallet)
            puts @dealer_total
            if @dealer_total < 17
              puts "here 6"
              deal_card(dealer_hand, deck.pick_random_card)
              d_ranks = display_hand_values(dealer_hand)
              d_values = convert_to_number(d_ranks)
              d_total = sum_hand_values(d_values)
              check_dealer_hand(d_ranks)
              add_won_bet_to_wallet(@result, new_wallet)
              puts @dealer_total
              if @dealer_total < 17
                deal_card(dealer_hand, deck.pick_random_card)
                d_ranks = display_hand_values(dealer_hand)
                d_values = convert_to_number(d_ranks)
                d_total = sum_hand_values(d_values)
                check_dealer_hand(d_ranks)
                add_won_bet_to_wallet(@result, new_wallet)
                puts @dealer_total
              end
            end
          end
        end
        end
    else  
      @turn = "dealer"
      puts "You stay. Your total is #{@total}"
      dealer = Dealer.new
      another_hand = Hand.new
      d_hand = another_hand.hand
      card_one = deck.pick_random_card
      card_two = deck.pick_random_card
      dealer_hand = deal_hand(d_hand, card_one, card_two)
      d_ranks = display_hand_values(dealer_hand)
      d_values = convert_to_number(d_ranks)
      d_total = sum_hand_values(d_values)
      check_dealer_hand(d_ranks)
      add_won_bet_to_wallet(@result, new_wallet)
      deal_card(dealer_hand, deck.pick_random_card)
      d_ranks = display_hand_values(dealer_hand)
      d_values = convert_to_number(d_ranks)
      d_total = sum_hand_values(d_values)
      check_dealer_hand(d_ranks)
      add_won_bet_to_wallet(@result, new_wallet)
      puts @dealer_total
      if @dealer_total < 17
        check_dealer_hand(d_ranks)
        add_won_bet_to_wallet(@result, new_wallet)
        puts @dealer_total
        if @dealer_total < 17
          check_dealer_hand(d_ranks)
          add_won_bet_to_wallet(@result, new_wallet)
          puts @dealer_total
          if @dealer_total < 17
            check_dealer_hand(d_ranks)
            add_won_bet_to_wallet(@result, new_wallet)
          end
        end
      end
      
    end
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
  attr_accessor :status
  def initialize
    @status = true
  end
  def make_bet(wallet)
    wallet - 10
  end
  def hit_or_stay
    while true
      puts "Would you like to (h)it or (s)tay? "
      answer = gets.chomp.downcase
      if answer[0] == "h"
        return true
      elsif answer[0] == "s"
        return false
      end
        puts "That is not a valid answer!"
    end
  end
end

class Dealer < Player
  def initialize
    
  end
end



