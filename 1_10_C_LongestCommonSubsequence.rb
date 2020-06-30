# 最長共通部分列
# 最長共通部分列は、2つの与えられた列X={x1,x2,...,xm}とY={y1,y2,...yn}の最長共通部分列を求める問題です。
# ある列ZがXとYの両方の部分列であるとき、ZをXとYの共通部分列といいます。
# 例えば、X={a,b,c,b,d,a,b}, Y={b,d,c,a,b,a}とすると、列{b,c,a}はXとYの共通部分列です。
# ただし長さ3の{b,c,a}は最長共通部分列ではない。
# 長さ5のものは存在しないので、長さ4の{b,c,b,a}は最長共通部分列の1つだといえる。
#
# 与えられた2つの文字列X,Yに対して、最長共通部分列Zの長さを出力するプログラム
# 与えられる文字列は英文字のみで構成されている。
# 入力例　# データセットの数 q #　q個の文字列X,Yが与えられる。
#   3
#   abcbdab
#   bdcaba
#   abc
#   abc
#   abc
#   bc
# 出力例
#   4 # 各データセットの最長共通部分列の長さ
#   3
#   2

# 動的計画法で求めるアルゴリズム
def longest_common_subsequence(x, y)
  m = x.length
  n = y.length
  max_length = 0
  c = Array.new(m+1){Array.new(n+1,0)}
  for i in 1..m
    for j in 1..n
      if x[i] == y[j]
        c[i][j] = c[i-1][j-1] + 1
      else
        c[i][j] = [c[i-1][j], c[i][j-1]].max
      end
      max_length =[max_length, c[i][j]].max
    end
  end
  max_length
end

# 再帰関数で求めるアルゴリズム
# def lcs(x,y,i,j)
#   return 0 if i == 0 || j == 0
#   if x[i] == y[j]
#     return lcs(x,y,i-1,j-1) + 1
#   else
#     return  [lcs(x,y,i-1,j) , lcs(x,y,i,j-1)].max
#   end
# end

q = gets.to_i
result = []
q.times do
  x = gets.to_s.strip
  y = gets.to_s.strip
  result << longest_common_subsequence(x, y)
  # result << lcs(x,y,x.length,y.length)
end
puts result

# X(x_n), Y(y_n)に対して、x_i,x_jについて考えたとき、
# ・最後の文字(x[i],y[j])が同じ場合、x[i-1]とy[j-1]の最長共通部分列の長さ+1がx[i]とx[j]の最長共通部分列である。
# ・最後の文字が異なる場合、x[i-1]とy[j]の最長共通部分列の長さか、もしくはx[i]とy[j-1]の長さのうち大きい方が、x[i]とy[j]の最長共通部分列である。
