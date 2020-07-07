# 幅優先探索
# 与えられた有向グラフG=(V,E)について、頂点1から各頂点への最短距離d(パス上の辺の数の最小値)を求めるプログラム
# (各頂点には1からnまでの番号が振られているものとする)
# 頂点1からたどり着けない頂点については、距離として-1を出力
#
# 入力例 # 最初の行にGの頂点数n,続くn行で各頂点uの隣接リスト
#   4
#   1 2 2 4
#   2 1 4
#   3 0
#   4 1 3
# 出力例
#   1 0 # id(頂点の番号) d(頂点1からその頂点までの距離)
#   2 1
#   3 2
#   4 1

class Graph < Array
  attr_accessor :number_of_v, :color, :d, :queue, :adj, :matrices, :distance
  def initialize(n)
    @number_of_v = n
    @color = Array.new(n,:white)
    @d = Array.new
    @queue = Array.new
    @adj = Array.new
  end

  def gets_adj_list
    number_of_v.times do |i|
      adj[i] = gets.split.map(&:to_i)
    end
    adj
  end

  def create_matrices_from_adj_list
    @matrices = Array.new(number_of_v) {Array.new(number_of_v,false)}
    adj.each do |adj|
      u, k, *v = adj[0], adj[1], adj[2..-1]
      v.flatten.each do |v|
        @matrices[u-1][v-1] = true
      end
    end
    matrices
  end

  def bfs(start_id:)
    initial_v_is start_id - 1
    queue << start_id - 1
    while not queue.empty?
      u = queue.shift
      for v in 0..number_of_v - 1
        if matrices[u][v] && white?(v)
          record_distance(v, u)
          queue << v
        end
      end
      change_color(u)
    end
  end

  def puts_result
    number_of_v.times do |i|
      puts "#{i+1} #{d[i]}"
    end
  end

  private

  def record_distance(to, from = 0)
    d[from] ||= -1
    d[to] = d[from] + 1
    change_color(to)
  end

  alias_method :initial_v_is, :record_distance

  def change_color(u)
    return color[u] = :gray if color[u] == :white
    return color[u] = :black if color[u] == :gray
  end

  def white?(v)
    color[v] == :white
  end
end


n = gets.to_i
adj = Graph.new(n)
adj.gets_adj_list
adj.create_matrices_from_adj_list
adj.bfs(start_id: 1)
adj.puts_result
