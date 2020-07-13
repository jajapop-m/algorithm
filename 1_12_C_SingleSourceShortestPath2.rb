# 単一始点最短経路2
# 1_12_B_SingleSourceShortestPath1における、
# n[1..10_000], c[0..100_000] <= nの最大値を増やした。
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
# 補足
# 1_12_Bのように、隣接行列を用いたアルゴリズムは、
# 頂点uに隣接する各頂点vを特定するための処理にO(V)の計算が必要であり、
# 更に最短経路木Sに追加する頂点uを選択するためのループ(V回)をV回行っていることから、
# O(V**2)のアルゴリズムとなる。
# このオーダーは隣接行列で表現しても隣接リストで表現しても同じである。
# =>ダイクストラのアルゴリズムは、隣接リストによる表現と二分ヒープ(優先度付きキュー)を
#   応用することによって、飛躍的に高速化出来る。

class Heap < Array
  def extract_min
    return nil if self.length < 2
    min = self[1]
    self.length>2 ? self[1] = self.pop : self.pop
    min_heapify(1)
    min
  end

  def min_heapify(idx)
    l = left(idx)
    r = right(idx)
    if l <= length - 1 && self[l].value < self[idx].value
      smallest = l
    else
      smallest = idx
    end
    smallest = r if r <= length - 1 && self[r].value < self[smallest].value
    if smallest != idx
      self[idx], self[smallest] = self[smallest], self[idx]
      min_heapify(smallest)
    end
  end

  def build_min_heap
    ((self.length-1) / 2).downto(1) do |idx|
      min_heapify idx
    end
  end

  def parent(idx)
    idx / 2
  end

  def left(idx)
    idx * 2
  end

  def right(idx)
    idx * 2 + 1
  end
end

class Graph
  attr_accessor :n, :ver, :matrices, :heap
  def initialize(number_of_vertexes)
    @n = number_of_vertexes
    gets_adj_list
    create_vertexes
    insert_heap
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
      @v_c = []
      n.times do |i|
        _,_,*@v_c[i] = gets.split.map(&:to_i)
      end
    end

    def set_root(v)
      ver[v].weight = 0
      ver[v].parent = -1
      heap.build_min_heap
    end

    def next_mincost_vertex
      min_ver = heap.extract_min
      min_ver&.id
    end

    def add_minimum_spanning_tree(u)
      ver[u].color = :black
    end

    def update_mindists(parent:)
      @v_c[parent].each_slice(2) do |id,cost|
        if ver[id].color != :black && cost + ver[parent].weight < ver[id].weight
          ver[id].weight = cost + ver[parent].weight
          ver[id].parent = parent
          ver[id].color = :gray
          heap.min_heapify(id)
        end
      end
    end

    def create_vertexes
      @ver = []
      n.times {|i| ver << V.new(i)}
    end

    def insert_heap
      @heap = Heap.new
      ver.each_with_index {|v,i| heap[i+1] = v}
    end
end

class V
  attr_accessor :id, :color, :weight, :parent
  alias_method :value, :weight
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
