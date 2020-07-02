# 深さ優先探索
# 深さ優先探索は可能な限り隣接する頂点を訪問する、という戦略に基づくグラフの探索アルゴリズム
# 未探索の接続編が残されている頂点の中で最後に発見した頂点vの接続編を再帰的に探索する。
# vの辺をすべて探索し終えると、vを発見したときに通ってきた辺を後戻りして探索を続行する。
# 探索はもとの始点から到達可能なすべての頂点を発見するまで続き、未発見の頂点が残っていれば、
# その中の番号が一番小さい一つの新たな始点として探索を続ける。
#
# 各頂点に以下のタイムスタンプを押す。
# ・タイムスタンプd[v]: vを最初に訪問した発見時刻を記録する。
# ・タイムスタンプf[v]: vの隣接リストを調べ終えた完了時刻を記録する。
#
# 与えられた有向グラフG=(V,E)に対する深さ優先探索の動作を示すプログラム
#
# 入力例 # Gの頂点数n # u k v1 v2 ... vk
#   6
#   1 2 2 3
#   2 2 3 4
#   3 1 5
#   4 1 6
#   5 1 6
#   6 0
# 出力例
#   1 1 12 # id(頂点の番号) d(頂点の発見時刻) f(頂点の完了時刻)
#   2 2 11
#   3 3 8
#   4 9 10
#   5 4 7
#   6 5 6

class Graph < Array
  def initialize(n)
    @n = n
    @color = Array.new(n, :white) # :white => 未訪問の頂点
    @stack = Array.new
    @d = Array.new(n)
    @f = Array.new(n)
    @time = 0
  end

  def dfs_with_stack(u)
    adj = get_adjacents(self)
    @stack.push(u)
    change_gray(u)
    discovery_time(u)

    while !@stack.empty?
      u = @stack.last
      v = adj[u].shift
      if v != nil
        if @color[v] == :white
          change_gray(v)
          discovery_time(v)
          @stack.push(v)
        end
      else
        @stack.pop
        change_black(u)
        completion_time(u)
      end
    end
    puts_result
  end

  private
    def get_adjacents(v) # 隣接する頂点の配列を取得 v1...vk
      adj = []
      v.each do |a|
        adj << a[2..-1].map{|i| i - 1} # 数字とインデックスを調節
      end
      adj
    end

    def discovery_time(u) # 発見時間
      @time += 1
      @d[u] = @time
    end

    def completion_time(u) # 完了時間
      @time += 1
      @f[u] = @time
    end

    def change_gray(u)
      @color[u] = :gray # :gray => 訪問した頂点
    end

    def change_black(u)
      @color[u] = :black # :black => 訪問を完了した頂点
    end

    def puts_result
      d_result = @d.to_enum
      f_result = @f.to_enum
      @n.times do |i|
        puts "#{i+1} #{d_result.next} #{f_result.next}"
      end
    end
end

n = gets.to_i
adj= Graph.new(n)
n.times do |i|
  adj[i] = gets.split.map &:to_i
end
adj.dfs_with_stack(0)

#
# def adj.adjacency_list_to_adjacency_matrices
#   matrices = Array.new(self.length) {Array.new(self.length,0)}
#   self.each do |adj|
#     u, k, *v = adj[0], adj[1], adj[2..-1]
#     v.flatten.each do |v|
#       matrices[u-1][v-1] = 1
#     end
#   end
#   matrices
# end
#
#
# matrices = adj.adjacency_list_to_adjacency_matrices
#
#
# class Graph
#   def initialize(n)
#     @status = Array.new(n, :waiting)
#     @matrices = Array.new(n){Array.new(n, false)}
#     @stack = Array.new
#   end
#
#   def dfs(matrix)
#     matrix.each_with_index do
#
#     end
#   end
# end
#
# graph = Graph.new(n)
# graph.dfs(matrices)
