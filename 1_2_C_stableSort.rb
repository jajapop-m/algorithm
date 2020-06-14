# 安定なソート
# バブルソートは安定だが、選択ソートは不安定なソートだと知られている。
# 選択ソートの結果が安定か不安定かを判定する。
# 数字によりソートする
# 入力
#   5
#   H4 C9 S4 D2 C3
# 出力
#   D2 C3 H4 S4 C9（バブルソート）
#   Stable
#   D2 C3 H4 S4 C9（選択ソート）
#   Not Stable

def bubbleSort(a, n)
  flag = true
  while flag do
    for i in 0..n-1 do
      flag = false
      for j in (i+1..n-1).to_a.reverse do
        if a[j][1] < a[j-1][1]
          a[j-1], a[j] = a[j], a[j-1]
          flag = true
        end
      end
    end
  end
  puts a.join(" ")
end

def selectionSort(a, n)
  for i in 0..n-1 do
    minj = i
    for j in i..n-1 do
      if a[j][1] < a[minj][1]
        minj = j
      end
    end
    a[i], a[minj] = a[minj], a[i]
  end
  puts a.join(" ")
end

class Array
  def stable?(out)
    n = self.length
    for i in 0..n-1 do
      for j in i+1..n-1 do
        for a in 0..n-1 do
          for b in a+1..n-1 do
            if self[i][1] == self[j][1] && self[i] == out[b] && self[j] == out[a]
              return "Not Stable"
            end
          end
        end
      end
    end
    "Stable"
  end

  def compare_with_bubble_sort(bubble_sort)
    for i in 0..self.length do
      return "Not Stable" if self[i] != bubble_sort[i]
    end
    "Stable"
  end
end

n = gets.to_i
original = gets.split
bubble_sort = original.dup
selection_sort = original.dup

bubbleSort(bubble_sort, n)
puts bubble_sort.stable?(original)
puts bubble_sort.compare_with_bubble_sort bubble_sort

selectionSort(selection_sort, n)
puts selection_sort.stable?(original)
puts selection_sort.compare_with_bubble_sort bubble_sort
