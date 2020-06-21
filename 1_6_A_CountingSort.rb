# 計数ソート(バケツソート、バケットソート)
# 計数ソートは各要素が0以上k以下である要素数nの数列に対して、線形時間(O(n+k))で動く高速で安定なソーティングアルゴリズム
# 数列Aを読み込み、計数ソートのアルゴリズムで昇順に並べ替え、出力するプログラム
# 入力例
#   7  # 数列Aの長さを表す整数n 1 ≦ n ≦ 2_000_000
#   2 5 1 3 2 3 0 #各要素は0以上10_000以下
# 出力例
#   0 1 2 2 3 3 5

N = gets.to_i
array = gets.split.map(&:to_i)

module CountingSort
  refine Array do
    def return_counting_array
      counter = Array.new(self.max + 1, 0)
      self.each{|i| counter[i] += 1}
      counter
    end

    def cumulate
      for i in 1..self.length-1
        self[i] = self[i] + self[i-1]
      end
      self
    end

    def counting_sort
      counter = self.return_counting_array.cumulate
      result = Array.new(self.length + 1)
      for i in (0..self.length-1).to_a.reverse
        result[counter[self[i]]] = self[i]
        counter[self[i]] -= 1
      end
      result.compact
    end
  end
end

using CountingSort
p array.counting_sort.join(" ")
