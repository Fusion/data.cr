require "../src/crdata/*"

module CRData
  class Util
    def self.test_stack
      s = Stack(String).new ["A", "B", "C", "D", "E"]
      s = s << "F"
      puts "First stack: #{s}"
      # l2 = "hello" + l
      # l2a = "world" + l
      # l3 = "hello" + l2a
      # puts "Second list: #{l2}"
      # puts "Alt Second list: #{l2a}"
      # puts "Third list: #{l3}"
      # puts "First list: #{l}"
      # puts "First element of first list: #{l.head}"
      # puts "Tail of first list: #{l.tail}"
      # puts "Tail of third list: #{l3.tail}"
      # puts "Now iterating these third list entries:"
      it = s
      loop do
        break if it.empty?
        item, it = it.pop
        puts "Head: #{item} Remainder: #{it}"
      end
      puts s.to_a
      newit = it << "Z"
      puts newit.to_a
    end
  end

  ###
  Util.test_stack
end
