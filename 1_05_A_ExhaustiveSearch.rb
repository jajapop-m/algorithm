# 全探索
# 長さnの数列Aと整数mに対して、Aの要素の中のいくつかの要素を足し合わせてmが作れるかどうかを判定するプログラム
# 入力例
#   5 # n
#   1 5 7 10 21 # 2000 ≧ 数列A ≧ 1
#   4 # q
#   2 4 17 8 # 2000 ≧ m_1 m_2 m_3 m_4 ≧ 1
# 出力例
#   no #数列Aの足し合わせで2を作れない
#   no
#   yes #数列Aの足し合わせで17を作れる　例）7 + 10
#   yes

N = gets.to_i
array = gets.split.map(&:to_i)
Q = gets.to_i
array_m = gets.split.map(&:to_i)

def array.can_make_number?(target_number, i = 0)
  return true if target_number == 0
  return false if i >= N
  result = self.can_make_number?(target_number, i + 1) || self.can_make_number?(target_number - self[i], i + 1)
  return result
end

array_m.each do |target_number|
  if array.can_make_number?(target_number)
    puts 'yes'
  else
    puts 'no'
  end
end

# 例えばarray_mの17のとき、target_numberは、以下のように分岐する
# i = 0                         17
# i = 1                17               16
# i = 2           17        12      16       11
# i = 3       17     10   12  5   16   9   11   4
# i = 4     17  7  10   0
#                       ↑ true これがcan_make_number?(0,4)の返り値となり、resultに結果が入り、最終的な結果はtrueとなる
