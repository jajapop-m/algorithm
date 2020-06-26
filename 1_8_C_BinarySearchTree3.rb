# 二分探索木：削除
# B_BinarySearchTree2にdelete命令を追加し、二分探索木Tに対し、以下の命令を実行するプログラム
# ・insert k: T にキーkを挿入する。
# ・print: キーを木の中間順巡回と先行順巡回アルゴリズムで出力する。(TreeWalkを参照)
# ・find k: Tにキーkが存在するか否かを報告する。
# ・delete k: キーkを持つ節点を削除する。
#
# 入力例
#   18 # 命令の数 m
#   insert 8
#   insert 2
#   insert 3
#   insert 7
#   insert 22
#   insert 1
#   find 1
#   find 2
#   find 3
#   find 4
#   find 5
#   find 6
#   find 7
#   find 8
#   print
#   delete 3
#   delete 7
#   print
# 出力例
#   yes
#   yes
#   yes
#   no
#   no
#   no
#   yes
#   yes
#    1 2 3 7 8 22
#    8 2 1 3 7 22
#    1 2 8 22
#    8 2 1 22


Node = Struct.new(:key, :parent, :left, :right)

class BinarySearchTree
  attr_accessor :root
  def insert key
    node_k = Node.new(key)
    node_parent = nil
    node_x = self.root
    while node_x != nil
      node_parent = node_x
      if node_k.key < node_x.key
        node_x = node_x.left
      else
        node_x = node_x.right
      end
    end
    node_k.parent = node_parent

    if node_parent == nil
      self.root = node_k
    elsif node_k.key < node_parent.key
      node_parent.left = node_k
    else
      node_parent.right = node_k
    end
  end

  def find key
    node = self.root
    while node != nil && key != node.key
      if key < node.key
        node = node.left
      else
        node = node.right
      end
    end
    node
  end

  def find? key
    if find key
      puts 'yes'
    else
      puts 'no'
    end
  end

  def delete key
    z = find key
    if z.left.nil? || z.right.nil?
      y = z
    else
      y = get_successor z
    end

    if y.left != nil
      x = y.left
    else
      x = y.right
    end

    if x !=nil
      x.parent = y.parent
    end

    if y.parent.nil?
      self.root = x
    elsif y == y.parent.left
      y.parent.left = x
    else
      y.parent.right = x
    end

    if y != z
      z.key = y.key
    end
  end

  def get_successor x
    return get_minimum x.right if x.right != nil
    y = x.parent
    while y != nil && x == y.right
      x = y
      y = y.parent
    end
    y
  end

  def get_minimum x
    while x.left != nil
      x = x.left
    end
    x
  end

  def preorder_parse(node = self.root)
    return if node == nil
    print " #{node.key}"
    preorder_parse(node.left)
    preorder_parse(node.right)
  end

  def inorder_parse(node=self.root)
    return if node == nil
    inorder_parse(node.left)
    print " #{node.key}"
    inorder_parse(node.right)
  end
end

tree  = BinarySearchTree.new
m = gets.to_i
commands = []
m.times do
  commands << gets.split
end
commands.each do |command|
  case command[0]
  when 'insert'
    tree.insert command[1].to_i
  when 'print'
    puts tree.inorder_parse
    puts tree.preorder_parse
  when 'find'
    tree.find? command[1].to_i
  when 'delete'
    tree.delete command[1].to_i
  else
    puts "不明なコマンド: #{command}"
  end
end

p tree
