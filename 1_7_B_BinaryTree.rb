# 二分木の表現
# 与えられた根付き二分木Tの各接点uについて、以下の情報を出力するプログラム
#   ・uの接点番号   ・uの深さ                                      0
#   ・uの親        ・uの高さ                                1          4
#   ・uの兄弟      ・接点の種類（根、内部点、葉）             2   3      5    8
#   ・uの子の数                                                    6  7
# ここでは、与えられる二分木はn個の接点を持ち、
# それぞれ0からn-1の番号が割り当てられているものとする。
#
# 入力例
#   9 # 接点の個数n
#   0 1 4 # id left(左の子の番号) right(右の子の番号)
#   1 2 3
#   2 -1 -1 # 子を持たない場合は-1で与えられる
#   3 -1 -1
#   4 5 8
#   5 6 7
#   6 -1 -1
#   7 -1 -1
#   8 -1 -1
# 出力例
#   node 0: parent = -1, sibling = -1 , degree = 2, depth = 0, height = 3, root
#   node 1: parent = 0, sibling = 4 , degree = 2, depth = 1, height = 1, internal node
#   node 2: parent = 1, sibling = 3 , degree = 0, depth = 2, height = 0, leaf
#   node 3: parent = 1, sibling = 2 , degree = 0, depth = 2, height = 0, leaf
#   node 4: parent = 0, sibling = 1 , degree = 2, depth = 1, height = 2, internal node
#   node 5: parent = 4, sibling = 8 , degree = 2, depth = 2, height = 1, internal node
#   node 6: parent = 5, sibling = 7 , degree = 0, depth = 3, height = 0, leaf
#   node 7: parent = 5, sibling = 6 , degree = 0, depth = 3, height = 0, leaf
#   node 8: parent = 4, sibling = 5 , degree = 0, depth = 2, height = 0, leaf

class Integer
  def exist?
    self >= 0
  end
end

class Node
  attr_accessor :parent, :left, :right, :sibling, :node_type, :degree, :depth, :height
  def initialize
    self.node_type = 'root'
    self.degree = 0
  end

  def self.preparation_node(n)
    node = Hash.new
    n.times do |i|
      node[i] = Node.new
    end
    node
  end

  def have_right_child?
    self.right != nil
  end

  def have_left_child?
    self.left != nil
  end
end

N = gets.to_i
node = Node.preparation_node(N)

class << node
  NOT_EXIST = -1

  def create_relationship(parent_id, child_id, whitch)
    self[parent_id].send whitch, child_id
    self[parent_id].degree += 1
    self[child_id].parent = parent_id
    change_type(parent_id, child_id)
  end

  def create_sibling(a_child, another)
    self[a_child].sibling = another
    self[another].sibling = a_child
  end

  def change_type(parent_id, child_id)
    self[child_id].node_type = 'leaf'
    self[parent_id].node_type = 'internal node' if self[parent_id].parent
  end

  def set_relationships(n)
    n.times do |i|
      id, l_child, r_child = gets.split.map(&:to_i)
      create_relationship id, l_child, :left= if l_child.exist?
      create_relationship id, r_child, :right= if r_child.exist?
      create_sibling r_child, l_child if l_child.exist? && r_child.exist?
    end
  end

  def set_depth(id=0, d=0)
    self[id].depth = d
    set_depth(self[id].right, d + 1) if self[id].have_right_child?
    set_depth(self[id].left, d + 1) if self[id].have_left_child?
    self
  end

  def set_height(id=0)
    temp_l = 0; temp_r = 0
    temp_l = set_height(self[id].right) + 1 if self[id].have_right_child?
    temp_r = set_height(self[id].left) + 1 if self[id].have_left_child?
    self[id].height = [temp_l, temp_r].max
  end

  def puts_details
    self.each do |n|
      index = n[0]; node = n[1]
      puts <<~NODE
        node #{index}: parent = #{node.parent || NOT_EXIST}, sibling = #{node.sibling || NOT_EXIST} ,\
         degree = #{node.degree}, depth = #{node.depth}, height = #{node.height}, #{node.node_type}
      NODE
    end
  end
end

node.set_relationships(N)
node.set_depth.set_height

node.puts_details

# 基本的には二分木は Node = Struct.new(:parent, :left, :right) で実装できる。
# set_heightは、最も深いnodeに対して、呼び出すと、set_height(6) => 0が返る。
# set_height(5) => temp_l = set_height(6) (==0+1)
#                  temp_r = set_height(7) (==0+1)  => node(5) = max(==1)
# set_height(4) => temp_l = set_height(5) (==1+1)
#                  temp_r = set_height(8) (==0+1)  => node(4) = max(==2)
# ...
