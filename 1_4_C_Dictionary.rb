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
hogehoge
OCUPYED = 0
EMPTY = 1
DELETED = 2

def create_hash_table(hash_size = 7)
  Array.new(hash_size, [nil, EMPTY])
end

def get_hash_value(key, table_size)
  key % table_size
end

def get_rehash_value(key, table_size)
  1 + (key % (table_size - 1))
end

def get_char(str)
  for i in 0..n
    case str[i]
    when 'A'
      1
    when 'C'
      2
    when 'G'
      3
    when 'T'
      4
    else
      nil
    end
  end
end

def insert(str)

end

def find(str)

end
