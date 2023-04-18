# frozen_string_literal: true

# プレイヤーを表すクラス
class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  # カードを引く(ヒット)
  def draw_card(card)
    @hand << card
  end

  # 手札を空にする
  def clear_hand
    @hand = []
  end

  # 手札の点数を計算する
  def total_point
    # 各カードの得点を取得し、それらを合計する
    total = @hand.sum(&:card_point)
    # Aceが手札にあり、かつ合計が21を超えた場合に、合計点を-10することでAceを1点として扱ったものとする。
    @hand.each do |card|
      total -= 10 if card.rank == 'Ace' && total > 21
    end
    total
  end

  # 手札と合計点を出力する
  def hands_and_total_point
    puts "#{@name}の手札: #{@hand.join(', ')} (合計: #{total_point})"
  end
end

# 【補足】
# &とシンボルを使って簡潔に書く
# このコードを
# [1, 2, 3, 4, 5, 6].select { |n| n.odd? } => [1,3,5]
# こう書き換えられる
# [1, 2, 3, 4, 5, 6].select { &:odd? } => [1,3,5]
