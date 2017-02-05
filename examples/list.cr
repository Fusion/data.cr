require "../src/crdata/*"

module CRData
  class Util
    def self.test_list
      l = List(String).new ["A", "B", "C", "D", "E"]
      puts "First list: #{l}"
      l2 = "hello" + l
      l2a = "world" + l
      l3 = "hello" + l2a
      puts "Second list: #{l2}"
      puts "Alt Second list: #{l2a}"
      puts "Third list: #{l3}"
      puts "First list: #{l}"
      puts "First element of first list: #{l.head}"
      puts "Tail of first list: #{l.tail}"
      puts "Tail of third list: #{l3.tail}"
      puts "Now iterating these third list entries:"
      it = l3
      loop do
        break if it.empty?
        puts "Head: #{it.head}"
        it = it.tail
      end
      puts l3.to_a
    end
  end

  ###
  Util.test_list
end
