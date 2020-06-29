# 入力
#   模式断面図における斜面を'/'と'\'、平地を'_'で表した文字列が1行に与えられる。
#   入力例
#   \\///\_/\/\\\\/_/\\///__\\\_\\/_\/_/\
# 出力
#   35 #地域に出来る水たまりの総面積
#   5 4 2 1 19 9 #水たまりの数k 各水たまりの面積を左から順に空白区切りで出力

def calculate_areas(cross_sections)
  distance_stack, areas = [], {}
  for i in 0..cross_sections.length
    if cross_sections[i] == "\\"
      distance_stack << i
    elsif cross_sections[i] == "/"
      next unless from = distance_stack.pop
      areas[from] = i - from + gets_old_areas(areas, from)
      areas.delete_if{|key, value| key > from }
    end
  end
  areas
end

def gets_old_areas(areas, from)
  areas.keys.select{|i| i > from}&.inject(0){|a,b| a + areas[b]}
end

def puts_result(areas)
  output = [areas.count] << areas.values
  puts total_areas = areas.values.inject(:+)
  puts each_areas = output.join(" ")
end

cross_sections = gets.split("")
puts_result calculate_areas(cross_sections)
