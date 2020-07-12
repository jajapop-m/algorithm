# 最小全域木
# 与えられた重み付きグラフG=(V,E)に対する最小全域木の辺の重みの総和を計算するプログラム
#
# 入力
#   最初の行にGの頂点数n
#   続くn行でGを表すn*nの隣接行列Aが与えられる。
#   Aの要素a_ijは頂点iと頂点jを結ぶ辺の重みを表す。(ただし、辺がなければ-1が示される)
# 入力例
#   5
#   -1 2 3 1 -1
#   2 -1 -1 4 -1
#   3 -1 -1 1 1
#   1 4 1 -1 3
#   -1 -1 1 3 -1
# 出力例 #Gの最小全域木の辺の重みの総和
#   5

class Graph
  attr_accessor :ver, :matrices
  def initialize(n)
    @ver = []
    @matrices = Array.new(n){Array.new(n,-1)}
    n.times do |i|
      ver << V.new(i)
      gets.split.map(&:to_i).each_with_index do |j,idx|
        j = Float::INFINITY if j == -1
        matrices[i][idx] = j
      end
    end
  end

  def prim
    ver[0].weight = 0
    ver[0].parent = -1
    loop do
      mincost = Float::INFINITY
      u = nil
      ver.each do |v|
        if v.color != :black && v.weight < mincost
          mincost = v.weight
          u = v.id
        end
      end
      break if mincost == Float::INFINITY
      ver[u].color = :black

      matrices[u].each_with_index do |cost,idx|
        if ver[idx].color != :black
          if cost < ver[idx].weight
            ver[idx].weight = cost
            ver[idx].parent =  u
            ver[idx].color = :gray
          end
        end
      end
    end
  end

  def sum
    ver.inject(0){|a,v| a + v.weight}
  end
end

class V
  attr_accessor :id, :color, :weight, :parent
  def initialize(id)
    @id = id
    self.color = :white
    self.weight = Float::INFINITY
  end
end

n = gets.to_i
graph = Graph.new(n)
graph.prim
puts graph.sum
graph.instance_eval{p @ver}
