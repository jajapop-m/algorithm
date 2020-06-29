# フィボナッチ数列
# フィボナッチ数列の第n項目を出力するプログラム
# fib(n) = 1 (n=0)
#          1 (n=1)
#          fib(n-1) + fib(n-2)
# 入力例
#   3 # 1つの整数n 0 ≦ n ≦ 64
# 出力例
#   3 # フィボナッチ数列の第n項目

# def fibonacci(n)
#   return 1 if n == 0 || n == 1
#   fibonacci(n-2) + fibonacci(n-1)
# end
# 上の関数でも求めることが出来るが、計算量で欠陥がある。
# 例えばf(5)を求めたいとき、f(4)とf(3)を呼び出すが、f(4)は再びf(3)を呼び出している。
# このように、一度計算した値を再び計算する無駄がある。

# => メモ化再帰によるフィボナッチ数列
# F = []
# def fibonacci(n)
#   return F[n] = 1 if n == 0 || n == 1
#   F[n] = fibonacci(n-2) + fibonacci(n-1)
# end

# => 動的計画法によるフィボナッチ数列
F = []
def fibonacci(n)
  F[0] = 1
  F[1] = 1
  [*2..n].each{|i| F[i] = F[i-2] + F[i-1]}
  F[n]
end

n = gets.to_i
puts fibonacci(n)
