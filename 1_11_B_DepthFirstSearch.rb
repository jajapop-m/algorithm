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

n = gets.to_i
adj=[]
n.times do |i|
  adj[i] = gets.split.map &:to_i
end

def adj.dfs_with_stack(u)
  n = self.length
  color = Array.new(n, :white)
  stack = Array.new
  d = Array.new(n)
  f = Array.new(n)
  time = 0

  adj = []
  self.each do |a|
    adj << a[2..-1]
  end

  stack.push(u)
  color[u] = :gray
  time += 1
  d[u] = time

  while !stack.empty?
    u = stack[-1]
    v = adj[u].shift
    if v != nil
      if color[v-1] == :white
        color[v-1] = :gray
        time += 1
        d[v-1] = time
        stack.push(v-1)
      end
    else
      stack.pop
      color[u] = :black
      time += 1
      f[u] = time
    end
  end
  d_result = d.to_enum
  f_result = f.to_enum
  n.times do |i|
    puts "#{i+1} #{d_result.next} #{f_result.next}"
  end
end

adj.dfs_with_stack(0)
