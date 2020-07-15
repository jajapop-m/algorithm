# 最大長方形
# 1辺が1cmのタイルがH*W個並べられている。タイルは汚れているもの、綺麗なもののいずれかである。
# 綺麗なタイルのみを使ってできる正方形の面積の最大値を求めるプログラム
# 入力例 # H(行) W(列) 1=>汚れたタイル 0=>綺麗なタイル H,W[1,1400]
#   4 5
#   0 0 1 0 0
#   1 0 0 0 0
#   0 0 0 1 0
#   0 0 0 1 0
# 出力例 #面積の最大値
#   6

h, w = gets.split.map &:to_i
lines = []
h.times do
  lines << gets.split.map(&:to_i)
end

Dirty = 1
Clean = 0

def map_pile_numbers(lines)
  heap = Array.new(lines.length){Array.new}
  lines.each_with_index do |line, i|
    line.each_with_index do |status, j|
      next heap[i][j] = 0 if status == Dirty
      next heap[i][j] = 1 if i==0 && status == Clean
      heap[i][j] = heap[i-1][j] + 1
    end
  end
  heap
end

Height = 0
Pos = 1

def largest_rectangle(line)
  stack = []
  max_area = 0
  line.each_with_index do |height, pos|
    next stack << [height, pos] if stack.empty? || stack.last[Height] < height
    next if stack.last[Height] == height
    while !stack.empty? && stack.last[Height] >= height
      rect = stack.pop
      max_area = [rect[Height] * (pos-rect[Pos]), max_area].max
    end
    stack << [height, rect[Pos]]
  end
  max_area
end

pile_numbers = map_pile_numbers(lines)
result = 0
pile_numbers.each do |line|
  result = [largest_rectangle(line), result].max
end
puts result
