# マインスイーパー

class Cell
  attr_accessor :id, :status, :revealed
  def initialize(id)
    @id = id
    @status = 0
    @revealed = false
  end

  def set_bomb
    status = :bomb
  end

  def set_number(num)
    status = num
  end

  def revealed?
    revealed
  end
end

class Board
  attr_accessor :n , :lists, :bomb_map, :bomb_count

  def initialize(n)
    @n = n
    @lists = Array.new(n){Array.new(n)}
    id = 0
    n.times do |i|
      n.times do |j|
        lists[i][j] = Cell.new(id)
        id += 1
      end
    end
  end

  def reveal(i,j)
    reveal_loop(i,j)
    check_game_status
  end

  def reveal_loop(i,j)
    lists[i][j].revealed = true
    return if lists[i][j].status == "B"
    return if (i < 0 || i > n-1 || j < 0 || j > n-1) || \
              lists[i][j].status != 0 && lists[i][j].status.to_s.match(/\d/)
    reveal_loop(i-1,j) if i-1 > -1 && (not lists[i-1][j].revealed?)
    reveal_loop(i+1,j) if i+1 < n  && (not lists[i+1][j].revealed?)
    reveal_loop(i,j-1) if j-1 > -1 && (not lists[i][j-1].revealed?)
    reveal_loop(i,j+1) if j+1 < n  && (not lists[i][j+1].revealed?)
  end

  def game_over
    lists.flatten.each do |l|
      l.revealed = true if l.status == "B"
    end
    puts_list
    puts "  GAME OVER"
  end

  def game_over?
    lists.flatten.each do |l|
      return true if l.status == "B" && l.revealed == true
    end
    false
  end

  def check_game_status
    if game_clear?
      puts_list
      puts "  CLEAR!! "
      return
    elsif game_over?
      game_over
      return
    end
    puts_list
  end

  def game_clear?
    count = 0
    lists.flatten.each do |l|
      count += 1 if l.revealed?
    end
    count == n*n - bomb_count
  end

  def puts_list
    result = []
    lists.flatten.each do |l|
      if l.revealed
        s =  l.status
        s == 0 ? result << "□" : result << s
      else
        result << "■"
      end
    end
    result.unshift([*1..n]).flatten!
    res = []
    result.each_slice(n).with_index do |r,i|
      next res[i] = r.unshift(" ") if i == 0
      res[i] = r.unshift(i)
    end
    res.each{|r| puts r.join(" ")}
  end

  def bomb_set(bomb_count)
    @bomb_count = bomb_count
    @bomb_map = Array.new(n*n,false)
    for c in 0...bomb_count
      bomb_map[c] = true
    end
    bomb_map.shuffle!
    bomb_map.each_with_index do |bomb, idx|
      lists.flatten[idx].status = "B" if bomb
    end
    numbers_set
  end

  def numbers_set
    bomb_map.each_slice(n).with_index do |line, i|
      line.each_with_index do |status, j|
        if status
          lists[i-1][j-1].status += 1 if (i != 0 && j != 0)     && lists[i-1][j-1].status != "B"
          lists[i-1][j].status += 1   if i != 0                 && lists[i-1][j].status != "B"
          lists[i-1][j+1].status += 1 if (i != 0 && j != n-1)   && lists[i-1][j+1].status != "B"
          lists[i][j-1].status += 1   if j != 0                 && lists[i][j-1].status != "B"
          lists[i][j+1].status += 1   if j != n-1               && lists[i][j+1].status != "B"
          lists[i+1][j-1].status += 1 if (i != n-1 && j != 0)   && lists[i+1][j-1].status != "B"
          lists[i+1][j].status += 1   if i != n-1               && lists[i+1][j].status != "B"
          lists[i+1][j+1].status += 1 if (i != n-1 && j != n-1) && lists[i+1][j+1].status != "B"
        end
      end
    end
  end

end

class Minesweeper
  attr_accessor :board
  def game_config
    puts "7×7マス,爆弾3個 でよろしいですか？(yes/no)"
    yes_or_no = gets.to_s.chomp
    if yes_or_no == "no"
      puts "縦横何マスずつにしますか？"
      n = gets.to_i
      puts "爆弾の個数は何個にしますか？"
      bomb = gets.to_i
    elsif yes_or_no == "yes"
      n, bomb = 7, 3
    else
      puts "もう一度入力して下さい。"
      return game_config
    end
    @board = Board.new(n)
    board.bomb_set(bomb)
  end

  def start
    game_config
    board.puts_list
    try_game
  end

  def try_game
    while not (board.game_clear? || board.game_over?)
      print "縦 横:"
      i,j = gets.split.map(&:to_i)
      i -= 1
      j -= 1
      board.reveal(i,j)
    end
    ask_again
  end

  def ask_again
    puts "もう一度プレイしますか？(yes/no)"
    yes_or_no = gets.to_s.chomp
    if yes_or_no == 'yes'
      start
    else
      puts "終了します"
      exit
    end
  end
end

# board = Board.new(7)
# board.bomb_set(1)
# board.puts_list
# board.reveal(1,1)
# board.puts_list
Minesweeper.new.start
