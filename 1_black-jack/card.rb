# frozen_string_literal: true

# トランプのカード
class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  # カードの情報を文字列として返す
  # def card_info
  #   "#{suit}の#{rank}"
  # end

  # カードのランクに応じて得点を返す
  def card_point
    case rank
    when 'Ace'
      11
    when 'King', 'Queen', 'Jack'
      10
    else
      rank.to_i
    end
  end
end

# 【用語】
# スート(suit)：スペード・ハート・ダイヤ・クラブ のこと。
# ランク(rank)：A ~ K のこと。

# 【豆知識】
# toString()は、JavaScriptのオブジェクトに対してよく使われるメソッドで、オブジェクトの内容を表す文字列を返すために使われます。
