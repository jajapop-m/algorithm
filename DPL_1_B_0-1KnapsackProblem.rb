# ナップザック問題
# 価値がvi重さがwiであるようなN個の品物と、容量がWのナップザックがある。
# 次の条件を満たす用に品物を選んでナップザックに入れる
# ・選んだ品物の価値の合計をできるだけ高くする。
# ・選んだ品物の重さの総和はWを超えない。
#
# 入力
#   一行目にN W　N[1,100],W[1,1000],w[1,1000],W[1,10000]
#   続くN行でi番目の品物の価値viと重さwi
# 入力例
#   4 5
#   4 2
#   5 2
#   2 1
#   8 3
# 出力例
#   13  # 価値の合計の最大値
# 解説
# 各品物を選択するor選択しないの組み合わせなので0-1ナップサック問題と言われる。
# N個の各品物について選択する,選択しないの組み合わせをすべて調べるアルゴリズムの計算量はO(2**N)
# => 品物の大きさw,ナップサックの大きさWがともに整数であれば、動的計画法により、O(NM)で厳密解を求められる。
# items[N+1]: items[i].v, items[i].wにi番目の品物の価値と重さが記録されている1次元配列
# c[N+1][W+1]: i個目までの品物を考慮して大きさwのナップサックに入れる場合の価値の合計の最大値をc[i][w]とする2次元配列
# 考慮する品物の数i、各iにおけるナップサックの重さwを増やしていき、c[i][w]を更新していく。
#   c[i][w] = max[1=>c[i-1][w-品物iの重さ]+品物iの価値, 2=>c[i-1][w]]
#   1:この時点で品物を選択する, 2:この時点で品物を選択しない

class Item
  attr_accessor :id, :value, :weight
  def initialize(id,value,weight)
    @id = id
    @value = value
    @weight = weight
  end
end

class Knapsack
  attr_accessor :capacity, :g, :n
  def initialize(capacity)
    @capacity = capacity
  end

  def compute(items)
    @n = items.length - 1
    c = Array.new(n+1){Array.new(capacity+1,0)}
    @g = Array.new(n+1){Array.new(capacity+1)}

    for i in 1..n
      for w in 1..capacity
        if items[i].weight <= w
          if items[i].value + c[i-1][w-items[i].weight] > c[i-1][w]
            c[i][w] = items[i].value + c[i-1][w-items[i].weight]
            g[i][w] = :diagonal
          else
            c[i][w] = c[i-1][w]
            g[i][w] = :top
          end
        else
          c[i][w] = c[i-1][w]
          g[i][w] = :top
        end
      end
    end
    c[n][capacity]
  end

  def items_number(items)
    items_number = []
    w = capacity
    for i in [*1..n].reverse
      if g[i][w] == :diagonal
        items_number << i
        w -= items[i].weight
      end
    end
    items_number
  end
end

n,w = gets.split.map(&:to_i)
items = Array.new(n)
n.times do |i|
  vi, wi = gets.split.map(&:to_i)
  items[i+1] = Item.new(i,vi,wi)
end

knapsack = Knapsack.new(w)
puts knapsack.compute(items)
p knapsack.items_number(items)
