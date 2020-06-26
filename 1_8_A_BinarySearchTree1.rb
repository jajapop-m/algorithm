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

Node = Struct.new(:parent, :left, :right)
node = Hash.new

class << node
  def insert k
    
  end

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
end


puts 'Preorder'
puts node.preorder_parse
puts 'Inorder'
puts node.inorder_parse
