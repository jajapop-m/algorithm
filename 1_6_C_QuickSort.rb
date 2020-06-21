# クイックソート
# n枚のカードの列を整列する。
# 各カードには1つの絵柄(S,H,C,D)と一つの数のペアが書かれている。
# これを数字の昇順に、クイックソートで並べ替えるプログラム。
# 入力例
#   6 #カードの枚数 1 ≦ n ≦100_000
#   D 3
#   H 2
#   D 1
#   S 3
#   D 2
#   C 1
# 出力例
#   Not stable #この出力が安定か否か
#   D 1
#   C 1
#   D 2
#   H 2
#   D 3
#   S 3

N = gets.to_i
CARD_NUMBER = 1
cards = []
N.times do
  cards << gets.split
end

def partition(array, p, r)
  x = array[r][CARD_NUMBER].to_i
  i = p - 1
  for j in p..r-1
    if array[j][CARD_NUMBER].to_i <= x
      i += 1
      array[i], array[j] = array[j], array[i]
    end
  end
  array[i+1], array[r] = array[r], array[i+1]
  i + 1
end

def quick_sort(array, p, r)
  if p < r
    pivot = partition(array, p, r)
    quick_sort(array, p, pivot-1)
    quick_sort(array, pivot+1, r)
  end
end

class Array
  def stable?(comparison)
    n = self.length
    for i in 0..n-1 do
      for j in i+1..n-1 do
        for a in 0..n-1 do
          for b in a+1..n-1 do
            if self[i][1] == self[j][1] && self[i] == comparison[b] && self[j] == comparison[a]
              return "Not Stable"
            end
          end
        end
      end
    end
    "Stable"
  end
end

cards_dup = cards.dup
quick_sort(cards, 0, N - 1)
puts cards.stable?(cards_dup)
cards.each{|i| puts i.join(" ")}

# partitionは初項がp,末項がrの数列に対してpivotの要素と比較して、小さいものと大きいものを左右に振り分ける。
# quick_sortでは、partitionにより返却されたpivotの前後の数列に対して、再帰的にquick_sortを実行する。
# quick_sortは p < r より、要素数が1以下の場合は、再帰を呼び出さないので、要素数1になると、再帰呼び出しが終了する。
# pivotの前後においては、pivotと比較するとソートは完了済みであるため、
# マージソートと比較すると、明示的に統治を行う必要はなく、また、追加のメモリを必要としない（インプレートソート）である。
# ※ただし、pivotを末尾としているため、ソート対象の配列の並び順によってはO(n**2)の計算量になってしまうため、
# 　基準をランダムに選ぶなど工夫をすると良い。
