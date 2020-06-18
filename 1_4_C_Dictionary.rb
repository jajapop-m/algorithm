# ハッシュ
# 以下の命令を受け付ける簡易的な辞書を実装
# insert str: 辞書に文字列strを追加する。
# find str:   その時点で辞書にstrが含まれる場合'yes'、含まれない場合'no'と出力する。
# 入力例
#   6 # 命令数n
#   insert AAA #insert,find + A,C,G,Tの４種類の文字（文字列は1文字以上12文字以下）
#   insert AAC
#   find AAA
#   find CCC
#   insert CCC
#   find CCC
# 出力例
#   yes
#   no
#   yes

KEY = 0
STATUS = 1
OCCUPIED = 0
EMPTY = 1
DELETED = 2

def input_result(result)
  @results = [] if not @results
  @results << result
end

def output_result
  puts @results
end

def create_hash_table(table_size)
  Array.new(table_size, [nil, EMPTY])
end

def get_hash_value(key, hash_table)
  key % hash_table.size
end

def get_rehash_value(key, hash_table)
  1 + (key % (hash_table.size - 1))
end

def get_str(str)
  str.gsub!('A', '1')
  str.gsub!('C', '2')
  str.gsub!('G', '3')
  str.gsub!('T', '4')
  str.gsub!(/\D/,'')
  str.to_i
end

def insert(str, hash_table)
  key = get_str(str)
  hash_value = get_hash_value(key, hash_table)
  target = hash_table[hash_value]

  hash_table.size.times do
    if target[STATUS] == EMPTY || target[STATUS] == DELETED
      hash_table[hash_value] = [key, OCCUPIED]
      return
    end
    hash_value = get_rehash_value(key, hash_table)
    target = hash_table[hash_value]
  end
  puts '値を追加するスペースがありません。'
end

def find(str, hash_table)
  result = []
  key = get_str(str)
  hash_value = get_hash_value(key, hash_table)
  target = hash_table[hash_value]

  hash_table.size.times do
    if target[STATUS] == OCCUPIED && target[KEY] == key
      input_result 'yes'
      return
    end
  end
  input_result 'no'
end

def gets_command(hash_table)
  command = gets.split.map(&:to_s)
  if command[0] == 'insert'
    insert(command[1], hash_table)
  elsif command[0] == 'find'
    find(command[1], hash_table)
  else
    puts '不明なコマンドです。'
  end
end


Default_hash_table_size = 7
hash_table = create_hash_table(Default_hash_table_size)

n = gets.to_i
n.times do
  gets_command(hash_table)
end
output_result
