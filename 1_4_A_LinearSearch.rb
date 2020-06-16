# 線形探索
# n個の整数を含む数列Sと、q個の異なる整数を含む数列Tを読み込み、
# Tに含まれる整数の中でSに含まれるものの個数を出力するプログラム
# 入力例
#   5
#   1 2 3 4 5
#   3
#   3 4 1
# 出力例
#   3

n = gets.to_i
set = gets.split.map(&:to_i)
q = gets.to_i
set_t = gets.split.map(&:to_i)

def linear_serch(set, set_t)
  count = 0
  set_t.each do |s|
    set.each do |t|
      count += 1 if s == t
    end
  end
  count
end

puts linear_serch(set, set_t)
