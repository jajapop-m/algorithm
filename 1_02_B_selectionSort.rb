# 選択ソート
# 入力例
#   6
#   5 6 4 2 1 3
# 出力例
#   1 2 3 4 5 6
#   4（交換回数）

def selectionSort(a, n)
  count = 0
  for i in 0..n-1 do
    minj = i
    for j in i..n-1 do
      if a[j] < a[minj]
        minj = j
      end
    end
    count += 1
    a[i], a[minj] = a[minj], a[i]
  end

  puts a.join(" ")
  puts count
end

n = gets.to_i
a = gets.split.map(&:to_i)
selectionSort(a, n)
