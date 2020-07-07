# 連結成分
# SNSの友達関係を入力し、双方向の友達リンクを経由してある人からある人へたどり着けるかどうかを判定するプログラム
#
# 入力
#   1行目にSNSのユーザ数を表す整数nと友達関係の数mが空白区切りで与えられる。n[2..100_000], m[0..100_000]
#     (SNSの各ユーザーには0からn-1までのIDが割り当てられている)
#   続くm行に1つの友達関係が各行に与えられる。
#     (1つの友達関係は空白で区切られた2つの整数s,tで与えられ、sとtが友達であることを示す。)
#   続く1行に、質問の数qが与えられる。
#   続くq行に質問が与えられる。                                      q[1..10_000]
#     (各質問は空白で区切られた2つの整数s,tで与えられ、「sからtへたどり着けますか？」という質問を意味する。)
# 入力例
#   10 9
#   0 1
#   0 2
#   3 4
#   5 7
#   5 6
#   6 7
#   6 8
#   7 8
#   8 9
#   3
#   0 1
#   5 9
#   1 3
# 出力例 #各質問に対して、sからtにたどり着ける場合はyes、たどり着けない場合はnoと1行に出力
#   yes
#   yes
#   no


class Users
  def initialize(n = 0)
    @@relations_table = []
    @@users = []
    n.times {|i| Users.add_user(i) }
  end

  class << self
    def add_user(id)
      users << User.new(id) unless Users.find(id)
      @@relations_table << []
    end

    def friends?(user1_id, user2_id)
      status = Array.new(users.length){:not_yet}
      queue = []
      queue << user1_id
      status[user1_id] = :checked
      while not queue.empty?
        current_id = queue.shift
        relations[current_id].each do |id|
          answer = (id == user2_id)
          return true if answer
          if status[id] == :not_yet
            queue << id
            status[id] = :checked
          end
          status[current_id] = :done
        end
      end
      false
    end

    def find(id)
      users[id]
    end

    def add_relations(follow_id, following_id)
      @@relations_table[follow_id] << following_id
    end

    def relations
      @@relations_table
    end

    private
      def users
        @@users
      end
  end
end

class User
  attr_accessor :id
  def initialize(id)
    @id = id
  end

  def follow_each_other(another_user)
    Users.add_relations(self.id, another_user.id)
    return if another_user.follow?(self) && follow?(another_user)
    another_user.follow_each_other(self)
  end

  def follow?(another_user)
    !!Users.relations[self.id].find_index(another_user.id)
  end
end


Follow, Following = 0, 1

n, m = gets.split.map &:to_i
list = []
m.times{|i| list[i] = gets.split.map(&:to_i)}

q = gets.to_i
list_q = []
q.times{|j| list_q[j] = gets.split.map(&:to_i)}

Users.new(n)
list.each{|li| Users.find(li[Follow]).follow_each_other(Users.find(li[Following]))}
list_q.each{|q| Users.friends?(q[Follow], q[Following]) ? (puts 'yes') : (puts 'no')}
