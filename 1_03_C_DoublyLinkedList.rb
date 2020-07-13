# 連結リスト
# 以下の命令を受け付ける双方向連結リストを実装
#   insert x: 連結リストの先頭にキーxを持つ要素を継ぎ足す
#   delete x: キーxを持つ最初の要素を連結リストから削除する
#   deleteFirst: 連結リストの先頭の要素を削除する
#   deleteLast: 連結リストの末尾の要素を削除する
# 入力例
#   7
#   insert 5
#   insert 2
#   insert 3
#   insert 1
#   delete 3
#   insert 6
#   delete 5
# 出力例 #すべての命令を終了した後の、連結リスト内のキーを順番に出力
#   6 1 2

n = gets.to_i
commands = []
n.times do
  commands << gets.split
end

list = []
commands.each do |command|
  case command[0]
  when 'insert'
    list << command[1]
  when 'delete'
    list.delete(command[1])
  when 'deleteFirst'
    list.shift
  when 'deleteLast'
    list.pop
  else
    "不明な命令: #{command[0]} #{command[1]}"
  end
end
puts list.reverse.join(" ")


# class Array
#   alias_method :insert, :<<
#   alias_method :deleteFrst, :shift
#   alias_method :deleteLast, :pop
# end
#
# commands.each do |command|
#   eval("#{command[0]}(#{command[1]})")
# end
#
# puts list.reverse.join(" ")
