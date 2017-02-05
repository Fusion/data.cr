require "../src/crdata/*"

module CRData
  class Util
    def self.test_stack
      s = Stack(String).new ["A", "B", "C", "D", "E"]
      s = s << "hello"
      s = s << "world"
      puts "First stack: #{s}"
      it = s
      loop do
        break if it.empty?
        item, it = it.pop
        puts "Popped: #{item}"
      end
      puts s.to_a
      newit = it << "Z"
      puts newit.to_a
    end
  end

  ###
  Util.test_stack
end
