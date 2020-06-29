# パーティション
# partition 配列A[p..r]をA[p..q-1]の各要素がA[q]以下で、A[q+1..r]の各要素が
# A[q]より大きいA[p..q-1]とA[q+1..r]に分割し、インデックスqを戻り値として返す。
# 入力例
#   12 # 数列Aの長さを表す整数n
#   13 19 9 5 12 8 7 4 21 2 6 11
# 出力例
#   9 5 8 7 4 2 6 [11] 21 13 19 12
#   分割された数列を1行に出力。partitionの基準となる要素を[ ]で示す

N = gets.to_i
array = gets.split.map(&:to_i)

def partition(array, p, r)
  x = array[r]
  i = p - 1
  for j in p..r-1
    if array[j] <= x
      i += 1
      array[i], array[j] = array[j], array[i]
    end
  end
  array[i+1], array[r] = array[r], array[i+1]
  i + 1
end

pivot = array[-1]
partition(array, 0, N-1)
puts array.join(" ").gsub(pivot.to_s,"[#{pivot}]")

# 数列arrayの初項p から i => x以下
# 　　　　　　  i+1 から j => xより大きい
# jは必ず1つずつ後方に進み、array[j]をどちらのグループに入れるかを順番に決めていく。
# 1.array[j]がx以下の場合
#   x以下の末尾であるiを一つ後方に進めてから、array[i]とarray[j]を交換する。
# 2.array[j]がxより大きい場合
#   要素の交換はせず、jを一つ進める。
