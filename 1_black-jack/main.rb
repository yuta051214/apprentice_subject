# frozen_string_literal: true

require './black_jack'

# ゲームの開始
print 'お名前を入力してください: '
player_name = gets.chomp
print 'NPCの人数を入力してください(0~2人): '
number = Integer(gets.chomp)
game = Blackjack.new(player_name, number)
game.start_game
