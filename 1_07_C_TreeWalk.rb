# 木の巡回
# 以下の3つのアルゴリズムで、与えられた二分木のすべての節点を体系的に訪問するプログラム
#   ・先行順巡回(Preorder Tree Walk) : 根接点、左部分木、右部分木野順で節点を訪問し、idを出力する。
#   ・中間順巡回(Inorder Tree Walk)  : 左部分木、根接点、右部分木野順で節点を訪問し、idを出力する。
#   ・後行順巡回(Postorder Tree Walk): 左部分木、右部分木、根節点の順で節点を訪問し、idを出力する。
# (与えられる二分木はn個の節点を持ち、それぞれ0からn-1の番号が割り当てられている。)
#          0
#     1          4
#   2   3     5    8
#           6   7
# 入力例
#   9 # 節点の個数 n
#   0 1 4 # id left right
#   1 2 3
#   2 -1 -1 # 子を持たない場合は-1
#   3 -1 -1
#   4 5 8
#   5 6 7
#   6 -1 -1
#   7 -1 -1
#   8 -1 -1
# 出力例
#   Preorder
#     0 1 2 3 4 5 6 7 8
#   Inorder
#     2 1 3 0 6 5 7 4 8
#   Postorder
#     2 3 1 6 7 5 8 4 0

N = gets.to_i
Node = Struct.new(:parent, :left, :right)
node = Hash.new
N.times do |i|
  node[i] = Node.new
end

N.times do |i|
  id, left_child, right_child = gets.split.map(&:to_i)
  node[id].left = left_child
  node[id].right = right_child
  node[left_child].parent = id if left_child >= 0
  node[right_child].parent = id if right_child >= 0
end

class << node
  def preorder_parse(id=0)
    return if id < 0
    print " #{id}"
    preorder_parse(self[id].left)
    preorder_parse(self[id].right)
  end

  def inorder_parse(id=0)
    return if id < 0
    inorder_parse(self[id].left)
    print " #{id}"
    inorder_parse(self[id].right)
  end

  def postorder_parse(id=0)
    return if id < 0
    postorder_parse(self[id].left)
    postorder_parse(self[id].right)
    print " #{id}"
  end
end


puts 'Preorder'
puts node.preorder_parse
puts 'Inorder'
puts node.inorder_parse
puts 'Postorder'
puts node.postorder_parse

# preorder_parseは、呼び出されるとprintを実行する。左部分木の訪問が終了したら、右部分木を訪問する。
#
# inorder_parseの挙動を詳しく見ていく。
#   inorder_parse(2)や(3)はprintのみ実行する。(parse(self[id].left)の引数が負となり、実行を終了するため)
#   そして、inorder_parse(1)は、parse(2)->print->parse(3)と実行する。
#   よって、print(2)->print(1)->print(3)と実行していく。
#   さらに、inorder_parse(0)は、parse(1)->print->parse(4)と実行する。
#   よって、print(2)->print(1)->print(3)->print(0)と実行することになる。
#   inorder_parse(4)は、parse(5)->print(4)->parse(8)
#   inorder_parse(5)は、parse(6)->print(5)->parse(7)
#   inorder_parse(6)や(7)は、print(6),print(7)を実行するため、
#   最終的には、print(2)->print(1)->print(3)->print(0)->print(6)->print(5)->print(7)->print(8)
#   と実行されることになる。
#
# postorder_parseの挙動を詳しく見ていく。
#   postorder_parse(2)や(3)はprintのみ実行する。
#   そして、postorder_parse(1)は、parse(2)->parse(3)->print(1)と実行する。
#   よって、print(2)->print(3)->print(1)と実行していく。
#   ...
