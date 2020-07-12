# 単一始点最短経路
# 与えられた重み付き有向グラフG=(V,E)について、単一始点最短経路のコストを求めるプログラム
# Gの頂点0を始点とし、0から各頂点vについて、最短経路上の辺の重みの総和d[v]を出力
# 入力
#   最初の行にGの頂点数n
#   続くn行で各頂点uの隣接リストが以下の形式で与えられる
#   u k v1 c1 v2 c2 ... vk ck
#   u:頂点の番号, k:uの出次数, vi:uに隣接する頂点の番号, ci:uとviを繋ぐviを繋ぐ有向辺の重み
# 入力例
#   5
#   0 3 2 3 3 1 1 2
#   1 2 0 2 3 4
#   2 3 0 3 3 1 4 1
#   3 4 2 1 0 1 1 4 4 3
#   4 2 2 1 3 3
# 出力例 # 各頂点の番号v 距離d[v]
#   0 0
#   1 2
#   2 2
#   3 1
#   4 3

n = gets.to_i
v_c = []
n.times do |i|
  _,_,*v_c[i] = gets.split.map(&:to_i)
end

matrices = Array.new(n){Array.new(n,Float::INFINITY)}
v_c.each_with_index do |vc,idx|
  vc.each_slice(2) do |v,c|
    matrices[idx][v] = c
  end
end
p matrices
