# 最長増加部分列
# 数列A[a_n]の最長増加部分列(LIS:Longest Increasing Subsequence)の長さを求めよ。
# 数列Aの増加部分列は0 <= i0 < i1 <...< ik < nかつai_0 < ai_1 <...<ai_kを満たす部分列ai_0,ai_1,...,ai_kである。
# 最長増加部分列はその中で最もkが大きいものである。
# 入力例 # 1行目に数列Aの長さn、続くn行で数列の各要素ai
#   5
#   5
#   1
#   3
#   2
#   4
# 出力例 #最長増加部分列の長さ
#   3
#
# 解説
# 長さnの数列Aの部分列の組み合わせは2**n通り
# => LISは動的計画法で効率よく求められる。
#
# 方法１ - 動的計画法で最長部分列を求めるアルゴリズム
#   L[n+1]: L[i]をA[1]からA[i]までの要素を使いA[i]を最後に選んだときのLISの長さとする配列
#   P[n+1]: P[i]をA[1]からA[i]までの要素を使いA[i]を最後に選んだときのLISの最後から２番目の要素の位置とする配列
#           (得られる最長部分列における各要素の1つ前の要素の位置を記録する)
#   def lis
#     l[0] = 0
#     a[0] = -1
#     p[0] = -1
#     for i in 1..n
#       k = 0
#       for j in 0..i-1
#         k = j if a[j] < a[i] && l[j] > l[k]
#       end
#       l[i] = l[k] + 1
#       p[i] k
#     end
#   end
#   => O(n**2)
#   => 動的計画法と二分探索を組み合わせてより効率的に求める。
# 方法2 - 動的計画法と二分探索を組み合わせたアルゴリズム
#   L[n]: L[i]を長さi+1であるような増加部分列の最後の要素の最小値とする配列
#   length_i: i番目の要素までを使った最長部分列の長さを表す整数

n = gets.to_i
ary = []
n.times{|i| ary[i] = gets.to_i }

def ary.lis
  l = []
  l[0] = self[0]
  length = 1
  for i in 1...self.length
    if l[length-1] >= self[i]
      j = l.bsearch_index{|x| x >= self[i]}
      l[j] = self[i]
    else
      length += 1
      l[length-1] = self[i]
    end
  end
  length
end

puts ary.lis
