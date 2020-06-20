# マージソート
# n個の整数を含む数列Sをマージソートで昇順に整列するプログラム
# 入力例
#   10 # n
#   8 5 9 2 6 3 7 1 10 4 # 数列Sを表すn個の整数 0≦n≦ 500_000
# 出力例
#   1 2 3 4 5 6 7 8 9 10
#   34 # mergeにおける比較回数

N = gets.to_i
array = gets.split.map(&:to_i)

$count = 0

def merge_sort(array1)
  return array1 if array1.length == 1
  array2 = array1.pop(array1.length / 2)
  merge(merge_sort(array1),merge_sort(array2))
end

def merge(array1, array2)
  len1, len2 = array1.length, array2.length
  result = Array.new(len1 + len2)
  array1[len1] = Float::INFINITY; array2[len2] = Float::INFINITY
  i, j, k = 0, 0, 0
  (len1 + len2).times do
    $count += 1
    if array1[i] < array2[j]
      result[k] = array1[i]
      i += 1; k += 1
    else
      result[k] = array2[j]
      j += 1; k += 1
    end
  end
  result
end

p merge_sort(array).join(" ")
p $count

# 1.merge_sortで分割する
#   引数に与えた配列を2等分し、前半(array1),後半(array2)に分割する。(popメソッドで破壊的に2等分している)
#   その2等分された2つの配列に対して、mergeを実行する。
#   要素数が2以上の場合、merge_sortの返り値はmergeのresultであるが、
#   mergeの引数で、merge_sortが再帰的に呼び出されているので、結果がすぐには返ってこない。
#   merge_sortにより要素数1まで分解されると、merge_sortはarray1を返却するので、
#   ここで、ようやく要素数1の2つの配列に対して、mergeが実行される。
#   そして、merge_sort(要素数が2のarray1)の返り値は、
#   merge(要素数1のarray1,要素数1のarray2)のresultであるが、これは先程実行し、結果を取得できる。
#   要素数3以上に対しても同様である。
#
# 2.mergeで統合する
#   最初には要素数1の2つの配列のソートから実行するが、遡ってmergeが実行されるので、
#   結果的にすべての分割された配列に対してmergeが実行される。
#   各mergeで、array1とarray2を比較すべき回数は、2つの配列の要素数の合計である。
#   ※array1, array2の片方が空になってしまうことで、array1[i]<array[j]の比較で
#   nilの比較によるAgumentErrorが発生してしまうのを回避するため、末尾にINFINITYを追加した。
#           array1, array2の要素をすべて取り出してしまったときに、
#           もう片方の要素を順にresultに追加する方法でも処理できる。
#             loop {
#               if a < b
#                 result[i] = a
#                 j += 1 ; i += 1
#                 break if j >= len1
#                 a = lst1[j]
#               else
#                 result[i] = b
#                 k += 1 ; i += 1
#                 break if k >= len2
#                 b = lst2[k]
#               end
#             }
#             while j < len1
#               result[i] = lst1[j]
#               i += 1 ; j += 1
#             end
#             while k < len2
#               result[i] = lst2[k]
#               i += 1 ; k += 1
#             end
