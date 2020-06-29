# 最大・最小ヒープ
# 与えられた配列からmax-ヒープを構築するプログラム(max-ヒープ条件:節点のキーがその親のキー以下である)
# 入力例
#   10 # 配列のサイズH
#   4 1 3 2 16 9 10 14 8 7
# 出力例 # max-ヒープの節点の値を節点の番号が1からHに向かって順番に一行で表示(各値の直前に一つの空白文字)
#    16 14 10 8 7 9 3 2 4 1

class HeapData
  attr_accessor :value
  def initialize(value)
    @value = value
  end
end

class Heap < Array
  def max_heapify(idx)
    l = left(idx)
    r = right(idx)
    if l <= length - 1 && self[l].value > self[idx].value
      largest = l
    else
      largest = idx
    end
    largest = r if r <= length - 1 && self[r].value > self[largest].value
    if largest != idx
      self[idx], self[largest] = self[largest], self[idx]
      max_heapify(largest)
    end
  end

  def build_max_heap
    ((self.length-1) / 2).downto(1) do |idx|
      max_heapify idx
    end
  end

  def parent(idx)
    idx / 2
  end

  def left(idx)
    idx * 2
  end

  def right(idx)
    idx * 2 + 1
  end
end


H = gets.to_i
array = gets.split.map &:to_i
heap = Heap.new
array.each_with_index do |a,idx|
  heap[idx+1] = HeapData.new(a)
end

heap.build_max_heap
puts heap.compact.map(&:value).join(" ")

# 二分ヒープはrootが1の幅優先探索順に割り当てられたキーを持つ、完全二分木で表されるが、実際は1次元配列で表す。
# 現在のキー(index)に対して、index/2が親、index*2が左の子、index*2+1が右の子を指す。
# 自身と左右の子で最大の値を持つnodeを取得する。
# それが自身と異なる場合は交換し、交換した子のindexに対して再帰的に判定と交換を行う。
# 二分ヒープの最大のindex(初項のnilを考慮しヒープを表す配列の長さ+1)の2分の1のindexから1まで以上の処理を行えば、
# すべてのnodeに対して、「節点のキーがその親のキー以下である」というmax-ヒープ条件を満たすヒープを作ることが出来る。
