# 挿入ソート
# 入力例
#   6
#   5 2 4 1 6 3
# 出力例
#   5 2 4 1 6 3
#   2 5 4 6 1 3
#   2 4 5 6 1 3
#   2 4 5 6 1 3
#   1 2 4 5 6 3
#   1 2 3 4 5 6

def trace(a)
  puts a.join(" ")
end

def insertionSort(a, n)
  for i in 1..n-1 do
    v = a[i]
    j = i - 1
    while j >= 0 && a[j] > v do
      a[j+1] = a[j]
      j -= 1
    end
    a[j+1] = v
    trace(a)
  end
end

n = gets.to_i
a = gets.split.map(&:to_i)
trace(a)
insertionSort(a, n)
