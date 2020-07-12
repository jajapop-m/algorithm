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


class Graph
  attr_accessor :n, :ver, :matrices
  def initialize(number_of_vertexes)
    @n = number_of_vertexes
    gets_adj_list
    create_vertexes
  end

  def dijkstra(n=0)
    init_all_vers_property
    set_root(n)
    loop do
      break unless u = next_mincost_vertex
      add_minimum_spanning_tree(u)
      update_mindists(parent: u)
    end
  end

  def puts_dists
    ver.each{|v| puts "#{v.id} #{v.weight}"}
  end

  private
    def init_all_vers_property
      ver.each {|v| v.init_color_and_dist }
    end

    def gets_adj_list
      v_c = []
      n.times do |i|
        _,_,*v_c[i] = gets.split.map(&:to_i)
      end
      @matrices = Array.new(n){Array.new(n,Float::INFINITY)}
      v_c.each_with_index do |vc,idx|
        vc.each_slice(2) do |v,c|
          matrices[idx][v] = c
        end
      end
    end

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

    def update_mindists(parent:)
      matrices[parent].each_with_index do |cost,idx|
        if ver[idx].color != :black && cost + ver[parent].weight < ver[idx].weight
          ver[idx].weight = cost + ver[parent].weight
          ver[idx].parent = parent
          ver[idx].color = :gray
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
    init_color_and_dist
  end

  def init_color_and_dist
    @color = :white
    @weight = Float::INFINITY
  end
end

n = gets.to_i
graph = Graph.new(n)
graph.dijkstra
graph.puts_dists
