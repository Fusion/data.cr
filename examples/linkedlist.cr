require "../src/crdata/*"

module CRData
  class Util
    def self.test_linkedlist
      l = LinkedList(String).new
      l << "a"
      l << "b"
      l << "c"
      l << "d"
      puts l
    end
  end

  ###
  Util.test_linkedlist
end
