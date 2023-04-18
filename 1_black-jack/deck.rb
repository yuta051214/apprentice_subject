# frozen_string_literal: true

require './card'

# トランプのデッキ
class Deck
  attr_reader :cards

  SUITS = %w[スペード ハート ダイヤ クラブ].freeze
  RANKS = %w[Ace 2 3 4 5 6 7 8 9 10 Jack Queen King].freeze

  # デッキインスタンスの生成時に、まず52個のカードインスタンスを生成し、さらにそれをシャッフルしてインスタンス変数 @cardsに代入する。
  def initialize
    @cards = []
    create_deck
    shuffle_cards
  end

  # カードインスタンスを生成して、インスタンス変数@cardsに配列として代入する
  def create_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  # カードの配列をシャッフルする
  def shuffle_cards
    @cards.shuffle!
  end

  # デッキからカードを１枚減らす
  def reduce_card
    @cards.pop
  end
end

# 【補足】
# freezeメソッド：イミュータブルにすることで、不変であることを保証する。
# pop メソッド：配列の最後尾から要素を1つ取り出して削除し、その要素を戻り値として返す。
