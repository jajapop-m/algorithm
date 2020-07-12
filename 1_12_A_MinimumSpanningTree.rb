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
  attr_accessor :n, :ver, :matrices
  def initialize(number_of_vertexes)
    @n = number_of_vertexes
    gets_matrices
    create_vertexes
  end

  def prim
    set_root(0)
    loop do
      break unless u = next_mincost_vertex
      add_minimum_spanning_tree(u)
      update_mincosts(parent: u)
    end
  end

  def sum_cost
    ver.inject(0){|a,v| a + v.weight}
  end

  private
    def set_root(v)
      ver[v].weight = 0
      ver[v].parent = -1
    end

    def next_mincost_vertex
      mincost = Float::INFINITY
      u = nil
      ver.each do |v|
        if v.color != :black && v.weight < mincost
          mincost = v.weight
          u = v.id
        end
      end
      u
    end

    def add_minimum_spanning_tree(u)
      ver[u].color = :black
    end

    def update_mincosts(parent:)
      matrices[parent].each_with_index do |cost,idx|
        if ver[idx].color != :black && cost < ver[idx].weight
          ver[idx].weight = cost
          ver[idx].parent = parent
          ver[idx].color = :gray
        end
      end
    end

    def gets_matrices
      @matrices = Array.new(n){Array.new(n,-1)}
      n.times do |i|
        gets.split.map(&:to_i).each_with_index do |j,idx|
          j = Float::INFINITY if j == -1
          matrices[i][idx] = j
        end
      end
    end

    def create_vertexes
      @ver = []
      n.times {|i| ver << V.new(i)}
    end
end

class V
  attr_accessor :id, :color, :weight, :parent
  def initialize(id)
    @id = id
    @color = :white
    @weight = Float::INFINITY
  end
end

n = gets.to_i
graph = Graph.new(n)
graph.prim
puts graph.sum_cost
