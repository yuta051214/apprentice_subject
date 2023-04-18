# frozen_string_literal: true

require './deck'
require './player'

# トランプゲームのメインクラス
class Blackjack
  attr_reader :deck, :player, :dealer

  def initialize(player_name, number)
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Player.new('ディーラー')
    return unless number.positive?

    @npc_players = participating_npc(number)
  end

  def start_game
    puts 'ブラックジャックを開始します!'
    draw_initial_cards  # 最初にお互い２枚ずつカードを引く
    show_initial_cards  # 手札を見せる
    player_turn  # プレイヤー：合計点が21を超えるか、standを選択するまでドローを続ける。
    dealer_turn  # ディーラー：合計点が17点以上になるまでドローを続ける。
    npc_turn unless @npc_players.empty? # NPC：合計点が17点以上になるまでドローを続ける。
    show_result # 結果の判定
    play_again?
  end

  private

  # 最初にお互い２枚ずつカードを引く
  def draw_initial_cards
    2.times do
      @player.draw_card(deck.reduce_card)
      @dealer.draw_card(deck.reduce_card)
      # NPC対応
      next if @npc_players.empty?

      @npc_players.each do |npc|
        npc.draw_card(deck.reduce_card)
      end
    end
  end

  # 最初の手札を見せる
  def show_initial_cards
    @player.hands_and_total_point
    puts "ディーラーの１枚目: #{@dealer.hand[0]}、２枚目はわかりません。"
  end

  # プレイヤー：合計点が21を超えるか、standを選択するまでドローを続ける。
  def player_turn
    while @player.total_point < 21
      print 'カードを引きますか？ (y/n): '
      choice = gets.chomp.downcase
      if choice == 'y'
        @player.draw_card(@deck.reduce_card)
        puts "#{@player.name}が引いたカードは #{@player.hand.last} です。 (合計: #{@player.total_point})"
      end
      break if choice != 'y' || @player.total_point >= 21
    end
  end

  # ディーラー：合計点が17点以上になるまでドローを続ける。
  def dealer_turn
    puts 'ディーラーのターン...'
    @dealer.hands_and_total_point
    while @dealer.total_point < 17
      @dealer.draw_card(@deck.reduce_card)
      puts "ディーラーの引いたカードは #{@dealer.hand.last} (合計: #{@dealer.total_point})"
    end
  end

  # NPC：合計点が17点以上になるまでドローを続ける。
  def npc_turn
    @npc_players.each do |npc|
      npc.draw_card(@deck.reduce_card) while npc.total_point < 17
    end
  end

  # 結果の判定
  def show_result
    @player.hands_and_total_point
    @dealer.hands_and_total_point
    # NPC
    @npc_players.each(&:hands_and_total_point) unless @npc_players.empty?

    # playerとNPCが入った配列を作る
    players = [@player] + @npc_players unless @npc_players.empty?

    # 判定
    players.each do |player|
      judge(player)
    end
  end

  def judge(player)
    # バーストの判定
    if player.total_point > 21
      puts "#{player.name}はバースト。 ディーラーの勝利!"
    elsif @dealer.total_point > 21
      puts "ディーラーはバースト。 #{player.name}の勝利!"
    # 引き分けの判定
    elsif player.total_point == @dealer.total_point
      puts '引き分けです!'
    # ブラックジャックの判定
    elsif player.total_point == 21
      puts "ブラックジャックです! #{player.name}の勝利!"
    elsif @dealer.total_point == 21
      puts 'ディーラーはブラックジャックです! ディーラーの勝利!'
    # 通常の判定
    elsif player.total_point > @dealer.total_point
      puts "#{player.name}の勝利!"
    else
      puts 'ディーラーの勝利!'
    end
  end

  # 手札をデッキに戻してもう一度遊ぶ。
  def play_again?
    print 'もう一度プレイしますか? (y/n): '
    choice = gets.chomp.downcase
    if choice == 'y'
      @deck = Deck.new
      @player.clear_hand
      @dealer.clear_hand
      # NPC対応
      @npc_players.each(&:clear_hand) unless @npc_players.empty?
      start_game
    else
      puts '遊んでくれてありがとう! またね!'
    end
  end

  # NPCを作成し、渡された数だけ返す
  def participating_npc(number)
    # NPCのインスタンスを用意する
    npc1 = Player.new('NPC-1')
    npc2 = Player.new('NPC-2')
    reserve_npc = [npc1, npc2]

    npc = []
    number.times do |n|
      npc << reserve_npc[n]
    end
    npc
  end
end
