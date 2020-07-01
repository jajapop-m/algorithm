# 連鎖行列積
# n子の行列の連鎖 M1,M2,M3,...,Mn が与えられたとき、
# スカラー乗算の回数が最小になるように積 M1M2M3...Mn の計算順序を決定する問題を連鎖行列積問題という。
#
# n個の行列について、行列Miの次元が与えられたとき、積 M1M2...Mn の計算に必要なスカラー乗算の最小の回数を求めるプログラム
# 入力例
#   6 # 行列の数n
#   30 35 # 行列 M1 の2つの整数 r(行), c(列)
#   35 15
#   15 5
#   5 10
#   10 20
#   20 25
# 出力例
#   15125 # 最小の回数

n = gets.to_i
p = []
n.times do |i|
  p[i], p[i+1] = gets.split.map &:to_i
end

def p.matrix_chain_multiplication(n)
  m = Array.new(n+1) { Array.new(n+1, 0)} # m[1][n]..m[n][1]までの計算結果を保持する2次元配列i==jのとき0とするため、0で初期化した。
  for length in 2..n                      # 連鎖行列積の長さをlengthとおく
    for i in 1..(n - length +1)           # 部分行列積の初項の位置を表すi
      j = i + length - 1                  # 部分行列積の末項の位置を表すj
      m[i][j] = Float::INFINITY
      for k in i..j-1                     # i ≦ k < j のk
        m[i][j] = [m[i][j], m[i][k] + m[k+1][j] + self[i-1] * self[k] * self[j]].min
      end
    end
  end
  m[1][n]
end

puts p.matrix_chain_multiplication(n)

# Mi~Mjの部分連鎖行列積の最適解はi≦k<jにおける(MiMi+1...Mk)(Mk+1...Mj)の最小コストである。
# 例えばM1M2...M5(i=1,j=5)の最適解は
# (M1)(M2M3M4M5) => (M1)のコスト + (M2M3M4M5)のコスト + p0 * p1 * p5 (k=1)
#   (左辺はp0*p1行列,右辺はp1*p5行列となるので、最後の2つの行列の掛け合わせではp0 * p1 * p5のコストがかかる。)
# (M1M2)(M3M4M5) => (M1M2)のコスト + (M3M4M5)のコスト + p0 * p2 * p5 (k=2)
# (M1M2M3)(M4M5) => (M1M2M3)のコスト + (M4M5)のコスト + p0 * p3 * p5 (k=3)
# (M1M2M3M4)(M5) => (M1M2M3M4)のコスト + (M5)のコスト + p0 * p4 * p5 (k=4)
# のうちの最小値となる。これをm[1][5]とする。
# => m[n+1][n+1]の配列領域が必要。(i==jのときは,m[i][j]==0である。)
# また、p[n+1]は、Miがp[i-1]*p[i]の行列を表す値を保存する1次元配列。

# 部分行列積の最小コストは二次元配列に保存されるので、m[1][n]の結果を返すために、
# 長さ2や3,..,n-1の再計算が必要ない。