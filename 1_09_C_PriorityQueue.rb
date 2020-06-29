# 優先度付きキュー
# 優先度付きキューは各要素がキーを持ったデータの集合Sを保持するデータ構造で、主に次の操作を行う。
#   ・insert (S, k): 集合Sに要素kを挿入する。
#   ・extractMax(S): 最大のキーを持つSの要素をSから削除してその値を返す。
# 優先度付きキューSに対して、insert(S,k), extractMax(S)を行うプログラム
#
# 入力例 # insert k, extract, endの形式で命令が1行で与えられる。
#   insert 8
#   insert 2
#   extract
#   insert 10
#   extract
#   insert 11
#   extract
#   extract
#   end
# 出力例 # extract命令ごとに、優先度付きキューSから取り出される値を1行に出力
#   8
#   10
#   11
#   2

class HeapData
  attr_accessor :value
  def initialize(value)
    @value = value
  end
end

class Heap < Array
  def excute_priority_queue
    build_max_heap
    commands = Array.new
    loop do
      command = gets.split
      case command[0]
      when 'end'
        break
      when 'insert'
        insert command[1].to_i
      when 'extract'
        puts extract_max.value
      else
        puts "不明なコマンド: #{command.join(" ")}"
      end
    end
  end

  def insert key
    self << nil if self.empty?
    self[self.length] = HeapData.new(key)
    i = self.length - 1
    while i > 1 && self[parent(i)].value < self[i].value
      self[i], self[parent(i)] = self[parent(i)], self[i]
      i = parent(i)
    end
  end

  def extract_max
    return 'error: heap under-flow' if self.length < 2
    max = self[1]
    self[1] = self.pop
    max_heapify(1)
    max
  end

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

heap = Heap.new
heap.excute_priority_queue
