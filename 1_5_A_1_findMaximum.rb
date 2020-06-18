# 配列Aのleftからright(rightを含まない）の範囲にある要素の最大数を分割統治法で探索

def find_maximum(array, left, right)
  mid = (left + right) / 2
  if left == right - 1
    return array[left]
  else
    u = find_maximum(array, left, mid)
    v = find_maximum(array, mid, right)
    x = [u, v].max
  end
  return x
end

array = gets.split.map(&:to_i)
puts find_maximum(array, 0, array.length)
