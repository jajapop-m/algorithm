# グラフの表現
# グラフG=(V,E) V:頂点の集合,E:辺の集合　の表現には、1.隣接リスト,2.隣接行列 による表現がある。
# 1.隣接リスト
#   Vの各頂点に対して1個、合計|V|個のリストAdj[|V|]でグラフを表す。
#   頂点uに対して、隣接リストAdj[u]はEに属する辺(u,vi)におけるすべての頂点viを含んでいる。
#   つまり、Adj[u]はGにおいてuと隣接するすべての頂点からなる。
# 2.隣接行列表現
#   頂点iから頂点jへ辺がある場合a_ijが1,ない場合0であるような|V|*|V|の行列Aでグラフを表す。
#
# 隣接リスト表現の形式で与えられた有向グラフGの隣接行列を出力するプログラム
# Gはn(=|V|)個の頂点を含み、それぞれ1からnまでの番号が振られているものとする。
#
# 入力例
#   4        # Gの頂点数n
#   1 2 2 4  # 拡張点uの隣接リストAdj[u]  u(頂点の番号) k(出次数) v1 v2 ... vk(隣接する頂点の番号)
#   2 1 4
#   3 0
#   4 1 3
# 出力例 # 隣接行列を出力
#   0 1 0 1
#   0 0 0 1
#   0 0 0 0
#   0 0 1 0

n = gets.to_i
adj=[]
n.times do |i|
  adj[i] = gets.split.map &:to_i
end

def adj.adjacency_list_to_adjacency_matrices
  matrices = Array.new(self.length) {Array.new(self.length,0)}
  self.each do |adj|
    u, k, *v = adj[0], adj[1], adj[2..-1]
    v.flatten.each do |v|
      matrices[u-1][v-1] = 1
    end
  end
  matrices
end

result =  adj.adjacency_list_to_adjacency_matrices
result.each{|r| puts r.join " "}
