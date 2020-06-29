# 二分探索
# n個の整数を含む数列Sと、q個の異なる整数を含む数列Tを読み込み、
# Tに含まれる整数の中でSに含まれるものの個数Cを出力する。
# 入力
#   5 # n
#   1 2 3 4 5 # S
#   3 # q
#   3 4 1 # T
# 出力
#   3 # C

NOT_FOUND = nil
n = gets.to_i
set = gets.split.map(&:to_i)
q = gets.to_i
set_t = gets.split.map(&:to_i)

def binary_search(set, set_t, key)
  left = 0
  right = set.length
  while left < right
    mid = (left + right) / 2
    if set[mid] == key
      return mid
    elsif key < set[mid]
      right = mid
    else
      left = mid + 1
    end
  end
  return NOT_FOUND
end

def count(set, set_t, count=0)
  for i in 0..set_t.length - 1
    count += 1 if binary_search(set, set_t, set_t[i])
  end
  count
end

puts count(set, set_t)
