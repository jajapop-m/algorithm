# 最大正方形
# 1辺が1cmのタイルがH*W個並べられている。タイルは汚れているもの、綺麗なもののいずれかである。
# 綺麗なタイル飲みを使ってできる正方形の面積の最大値を求めるプログラム
# 入力例 # H(行) W(列) 1=>汚れたタイル 0=>綺麗なタイル
#   4 5
#   0 0 1 0 0
#   1 0 0 0 0
#   0 0 0 1 0
#   0 0 0 1 0
# 出力例 #面積の最大値
#   4

h, w = gets.split.map &:to_i
lines = []
h.times do
  lines << gets.split.map(&:to_i)
end

Dirty = 1
Clean = 0

def max_square(lines)
  dp = Array.new(lines.length){Array.new}
  max_width = 0
  for i in 0..lines.length-1
    for j in 0..lines[i].length-1
      if i == 0 || j == 0
        if lines[i][j] == Clean
          dp[i][j] = 1
        elsif lines[i][j] == Dirty
          dp[i][j] = 0
        end
        next
      end
      next dp[i][j] = 0 if lines[i][j] == Dirty
      dp[i][j] = [dp[i][j-1], dp[i-1][j], dp[i-1][j-1]].min + 1
      max_width = [max_width, dp[i][j]].max
    end
  end
  [max_width**2, dp]
end

p max_square(lines)
