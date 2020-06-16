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

# 数列S内が重複しない場合、高速に処理
def linear_serch(set, set_t)
  sum = 0
  set_t.each do |s|
    sum += 1 if set.include? s
  end
end

puts linear_serch(set, set_t)

# set内の重複する要素も重複する分カウントする
# def linear_serch(set, set_t)
#   count = 0
#   set_t.each do |s|
#     set.each do |t|
#       count += 1 if s == t
#     end
#   end
#   count
# end

# 番兵を追加したfor文による処理
# def linear_serch(set, set_t)
#   sum = 0
#   for t in 0..set_t.length-1
#     i = 0
#     set[set.length] = set_t[t]
#     while set[i] != set_t[t]
#       i += 1
#     end
#     sum += 1 if i != set.length
#   end
#   sum
# end
