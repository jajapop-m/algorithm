# 二分探索木：挿入
# 二分探索木Tに対し、以下の命令を実行するプログラム
# ・insert k: T にキーkを挿入する。
# ・print: キーを木の中間順巡回と先行順巡回アルゴリズムで出力する。(TreeWalkを参照)
# 入力例
#   8 # 命令の数 m
#   insert 30
#   insert 88
#   insert 12
#   insert 1
#   insert 20
#   insert 17
#   insert 25
#   print
# 出力例
#    1 12 17 20 25 30 88 #中間順巡回アルゴリズム(各キーの前に1つの空白)
#    30 12 1 20 17 25 88 #先行順巡回アルゴリズム

Node = Struct.new(:key, :parent, :left, :right)

class BinarySearchTree
  attr_accessor :root
  def insert(key)
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

tree = BinarySearchTree
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
  else
    puts "不明なコマンド: #{command}"
  end
end
