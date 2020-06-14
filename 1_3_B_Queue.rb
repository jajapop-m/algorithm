# キュー
# n個のプロセスに対して、「ラウンドロビンスケジューリング」と呼ばれるプロセスを順番に処理する処理方法をシュミレートする。
# 例えばq（クオンタム）が100としたとき、4つのname(time)は次のように処理される。
# A(150) - B(80) - C(200) - D(200)
# のようなプロセスの場合、
# => B(80) - C(200) - D(200) - A(50)
# => C(200) - D(200) - A(50)
# => D(200) - A(50) - C(100)
# => A(50) - C(100) - D(100)
#
# 入力例
  # 5 100    #<= n q
  # p1 150   #<= name time
  # p2 80
  # p3 200
  # p4 350
  # p5 20
# 出力例　プロセスが完了した順に、各プロセスの名前と終了時刻を空白で区切って1行で出力
#   p2 180
#   p5 400
#   p1 450
#   p3 550
#   p4 800

def round_robin_scheduling(schedules)
  time = 0
  while !schedules.empty? do
    time += [schedules.first[1].to_i, 100].min
    if schedules.first[1].to_i > 100
      schedules.first[1] = schedules.first[1].to_i - 100
      schedules << schedules.shift
    else
      puts [schedules.shift[0], time].join(" ")
    end
  end
end


n, q = gets.split.map(&:to_i)
schedules = []
n.times do
  schedules << gets.split
end
round_robin_scheduling(schedules)
