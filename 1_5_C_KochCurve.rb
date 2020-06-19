# コッホ曲線（フラクタルの一種）
#
# コッホ曲線とは、以下のような再帰的な関数の呼び出しを用いて描画した図形である。
# ・与えられた線分(p1,p2)を3等分する。
# ・線分を3等分する2点s,tを頂点とする正三角形(s,u,t)を作成する。
# ・線分(p1,s),線分(s,u),線分(u,t),線分(t,p2)に対して再帰的に同じ操作を繰り返す。
#
# 入力例
#   1 # 0 <= n <= 6
# 出力例 コッホ曲線の拡張店の座標(x,y) 端点の一つ(0,0)から、もう一方の端点(100,0)
#       で終えるひとつづきの線分の列となるように１行に１点の座標を出力
#   0.00000000 0.00000000
#   33.33333333 0.00000000
#   50.00000000 28.86751346
#   66.66666667 0.00000000
#   100.00000000 0.00000000

include Math
N = gets.to_i

class Point
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

a = Point.new(0, 0)
b = Point.new(100, 0)

def koch(n, a, b)
  return a, b if n == 0

  s = trisection_left(a, b)
  t = trisection_right(a, b)
  u = trisection_top(s, t)

  koch(n-1, a, s)
  puts "%.8f %.8f" %[s.x, s.y]
  koch(n-1, s, u)
  puts "%.8f %.8f" %[u.x, u.y]
  koch(n-1, u, t)
  puts "%.8f %.8f" %[t.x, t.y]
  koch(n-1, t, b)
end

def trisection_left(a, b)
  new_x = (2 * a.x + b.x ) / 3.to_f
  new_y = (2 * a.y + b.y ) / 3.to_f
  Point.new(new_x, new_y)
end

def trisection_right(a, b)
  new_x = (a.x + 2 * b.x) / 3.to_f
  new_y = (a.y + 2 * b.y) / 3.to_f
  Point.new(new_x, new_y)
end

def trisection_top(s, t)
  new_x = (t.x - s.x) * cos(PI/3) -(t.y - s.y) * sin(PI/3) + s.x
  new_y = (t.x - s.x) * sin(PI/3) -(t.y - s.y) * cos(PI/3) + s.x
  Point.new(new_x, new_y)
end

puts "%.8f %.8f" %[a.x, a.y]
koch(N, a, b)
puts "%.8f %.8f" %[b.x, b.y]
