# 根付き木の表現
# 与えられた根付き木Tの各接点uについて、以下の情報を出力するプログラム
#   ・uの接点番号
#   ・uの親の接点番号
#   ・uの深さ
#   ・uの接点の種類（根、内部ノード、葉）
#   ・uの子のリスト
# 与えられる木はn個の接点を持ち、それぞれ0からn-1の番号が割り当てられている
# 入力例
#   13 # n
#   0 3 1 4 10 # id k(次数=子の個数) c_1 c_2...
#   1 2 2 3
#   2 0
#   3 0
#   4 3 5 6 7
#   5 0
#   6 0
#   7 2 8 9
#   8 0
#   9 0
#   10 2 11 12
#   11 0
#   12 0
# 出力例　# node id: parent = [親番号], depth = [接点の深さ], [親、内部接点、葉], [子のリスト]
#   node 0: parent = -1, depth = 0, root, [1, 4, 10]
#   node 1: parent = 0, depth = 1, internal node, [2, 3]
#   node 2: parent = 1, depth = 2, leaf, []
#   node 3: parent = 1, depth = 2, leaf, []
#   node 4: parent = 0, depth = 1, internal node, [5, 6, 7]
#   node 5: parent = 4, depth = 2, leaf, []
#   node 6: parent = 4, depth = 2, leaf, []
#   node 7: parent = 4, depth = 2, internal node, [8, 9]
#   node 8: parent = 7, depth = 3, leaf, []
#   node 9: parent = 7, depth = 3, leaf, []
#   node 10: parent = 0, depth = 1, internal node, [11, 12]
#   node 11: parent = 10, depth = 2, leaf, []
#   node 12: parent = 10, depth = 2, leaf, []

class Node
  attr_accessor :parent, :left, :right, :node_type
  def initialize
    self.node_type = "root"
  end

  def create_parent(parent_id)
    self.parent = parent_id
    self.change_type "leaf"
  end

  def create_child(child_left_id)
    self.left = child_left_id
    self.change_type "internal node" unless self.parent.nil?
  end

  def change_type(type)
    self.node_type = type
  end
end

N = gets.to_i
node = Hash.new

N.times do |id|
  node[id] = Node.new
end

class << node
  def get_children_list(a_node)
    children_list = []
    child = a_node.left
    if child
      children_list << child
      while self[child].right
        child = self[child].right
        children_list << child
      end
    end
    children_list
  end

  # def get_depth(a_node)
  #   depth = 0
  #   while a_node.parent >= 0
  #     a_node = self[a_node.parent]
  #     depth += 1
  #   end
  #   depth
  # end

  def set_depth(id=0, d=0, depth=Hash.new)
    depth[id] = d
    set_depth(self[id].right, d, depth) if self[id].right != nil
    set_depth(self[id].left, d + 1, depth) if self[id].left != nil
    depth
  end
end

N.times do |i|
  id, k, *c = gets.split.map(&:to_i)
  next if k.zero?                     # 子ノードがないならnext
  child_left = c[0]
  node[i].create_child child_left     # 子ノードの最も左側にあるものをleftへ
  node[child_left].create_parent id   # 子ノードの1つ目にとりあえず親を設定
  for r in 1..k-1                     # 子ノードが2つ以上なら、先程と同様に親を設定してから、先程のchild_leftのrightに自身を保存
    child_right = c[r]
    node[child_right].create_parent id
    node[child_left].right = child_right
    child_left = child_right
  end if k >= 2
end

depth = node.set_depth

N.times do |i|
  node[i].parent ||= -1
  puts <<~NODE
          node #{i}: parent = #{node[i].parent}, depth = #{depth[i]}, \
          #{node[i].node_type}, #{node.get_children_list(node[i])}"
        NODE
        # depth = node.get_depth(node[i])
end
