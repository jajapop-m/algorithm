# バブルソート
# 入力例
#   5
#   5 3 2 4 1
# 出力例
#   1 2 3 4 5
#   8（交換回数）

def bubbleSort(a, n)
  flag = true
  count = 0
  while flag do
    for i in 0..n-1 do
      flag = false
      for j in (i+1..n-1).to_a.reverse do
        if a[j] < a[j-1]
          a[j-1], a[j] = a[j], a[j-1]
          flag = true
          count += 1
        end
      end
    end
  end
  puts a.join(" ")
  puts count
end


n = gets.to_i
a = gets.split.map(&:to_i)
bubbleSort(a, n)
