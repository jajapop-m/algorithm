# 最適解の計算
# 重さがそれぞれw_1,w_...のn個の荷物をk台のトラックに積む。
# 各トラックには連続する0個以上の荷物を積んでいくが、最大積載量pを超えてはならない。
# トラックの最大積載量はpで、すべてのトラックで共通
# 1 ≦ n ≦ 100,000, 1 ≦ k ≦ 100,000, 1 ≦ w ≦ 10,000
# 入力例
#   5 3 # n k
#   8   # w_1
#   1
#   7
#   3
#   9
# 出力例
#   10 # p
# 1台目のトラックに2つの荷物{8,1}、2台目に{7,3}、3代目に{9}を積んで、最大積載量の最小値は10となる。
MAX_NUMBER_OF_LUGGAGE = 100_000
MAX_WEIGHT_OF_ONE_LUGGAGE = 10_000
N, K = gets.split.map(&:to_i)
w = []
N.times do
  w << gets.to_i
end

def w.check(p)
  i = 0
  K.times do
    a_truck = 0
    while a_truck + self[i] <= p #新しい荷物を積めるか？
      a_truck += self[i]
      i += 1
      return all_loaded if i == N
    end
  end
  return not_all_loaded
end

def all_loaded
  true
end

def not_all_loaded
  false
end

def solve(w)
  left = 0
  right = MAX_NUMBER_OF_LUGGAGE * MAX_WEIGHT_OF_ONE_LUGGAGE
  while left < right
    mid = (left + right) / 2
    if w.check(mid)
      right = mid
    else
      left = mid + 1
    end
  end
  mid
end

puts solve w
