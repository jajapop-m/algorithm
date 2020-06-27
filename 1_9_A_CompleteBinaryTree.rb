# 完全二分木
# 完全二分木で表された二分ヒープを読み込み、以下の形式で二分ヒープの各接点の情報を出力するプログラム
#   node id: key = 'k', parent key = 'pk', left key = 'lk', right key = 'rk',
# id(節点の番号(インデックス)), k(節点の値), pk(親の値), lk(左の子の値), rk(右の子の値)
# 該当する節点が存在しない場合は出力は行わないものとする。
# 入力例
#   5 # ヒープのサイズH
#   7 8 1 2 3 #二分ヒープの節点の値(キー)を表すH個の整数
# 出力例 #各行の最後は空白
#   node 1: key = 7, left key = 8, right key = 1,
#   node 2: key = 8, parent key = 7, left key = 2, right key = 3,
#   node 3: key = 1, parent key = 7,
#   node 4: key = 2, parent key = 8,
#   node 5: key = 3, parent key = 8,

H = gets.to_i
array = gets.split.map &:to_i
nodes = Array.new
array.each_with_index do |a,idx|
  nodes[idx+1] = a
end

class << nodes
  def puts_info
    self.each_with_index do |node, idx|
      next if node.nil?
      print "node #{idx}: key = #{node}, "
      print "parent key = #{self[parent(idx)]}, " if self[parent(idx)]
      print "left key = #{self[left(idx)]}, " if self[left(idx)]
      print "right key = #{self[right(idx)]}, " if self[right(idx)]
      print "\n"
    end
  end
end

def parent(int)
  int / 2
end

def left(int)
  int * 2
end

def right(int)
  int * 2 + 1
end

nodes.puts_info
