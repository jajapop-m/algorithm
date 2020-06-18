# n個の要素を持つ数列の要素を選ぶ組み合わせを列挙するプログラム　選択する(1)・しない(0)

def combination(n)
  array = Array.new(n, 0)
  rec(0, array)
end

def rec(i, array)
  if i == array.length
    p array
    return
  end

  rec(i + 1, array) # 1
  array[i] = 1
  rec(i + 1, array) # 2
  array[i] = 0
end

combination 3

# i = 0   1 rec(1, [0,0,0])  i = 1  1 rec(2, [0,0,0])  i = 2  1 rec(3, [0,0,0])
#                                                             2 rec(3, [0,0,1])
#                                   2 rec(2, [0,1,0])         1 rec(3, [0,1,0])
#                                                             2 rec(3, [0,1,1])
#         2 rec(1, [1,0,0])         1 rec(2, [1,0,0])         1 rec(3, [1,0,0])
#                                                             2 rec(3, [1,0,1])
#                                   2 rec(2, [1,1,0])         1 rec(3, [1,1,0])
#                                                             2 rec(3, [1,1,1])
