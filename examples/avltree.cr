require "../src/crdata/*"

module CRData
  class KVP
    include Comparable(KVP)

    property key, value

    def to_s(io)
      io << "#{@value}"
    end

    def initialize(@key : Int32, @value : String)
    end

    # Only interested in key for deletion or search
    def initialize(@key : Int32)
      @value = ""
    end

    def odd?
      @key.odd?
    end

    # Comparison will be used to sort in tree
    def <=>(other : T)
      @key <=> other.@key
    end
  end

  class Util
    def self.test_avltree_with_primitive_types
      add_items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
      del_items = [4, 10, 11, 12]
      t = AVLTree(Int32).new

      puts
      puts "** STORING #{add_items} **"
      add_items.each do |item|
        t.insert item
      end
      puts
      t.display
      puts "> #{t.dump_in_order}"
      print "Enumerable content: "
      puts t.to_a
      print "Filter: "
      puts t.select &.odd?

      print "Search: "
      puts "10 is this node: #{t.search(10).not_nil!.data}"

      puts
      puts "** DELETING #{del_items} **"
      del_items.each do |item|
        t.delete item
      end

      puts
      t.display
      puts "> #{t.dump_in_order}"
    end

    def self.test_avltree_with_objects
      add_items = [
        KVP.new(1, "O1"), KVP.new(2, "T2"), KVP.new(3, "T3"), KVP.new(4, "F4"),
        KVP.new(5, "F5"), KVP.new(6, "S6"), KVP.new(7, "S7"), KVP.new(8, "E8"),
        KVP.new(9, "N9"), KVP.new(10, "T10"), KVP.new(11, "E11"), KVP.new(12, "T12"),
      ]
      del_items = [KVP.new(4), KVP.new(10), KVP.new(11), KVP.new(12)]
      t = AVLTree(KVP).new

      puts
      print "** STORING "
      add_items.each do |item|
        print " #{item.value}"
        t.insert item
      end
      puts " **"
      puts
      t.display
      puts "> #{t.dump_in_order}"
      print "Enumerable content: "
      t.to_a.each { |x| print " #{x}" }
      puts
      print "Filter: "
      (t.select &.odd?).each { |x| print " #{x}" }
      puts

      print "Search: "
      puts "10 is this node: #{t.search(KVP.new(10)).not_nil!.data}"

      puts
      print "** DELETING "
      del_items.each do |item|
        print " #{item.key}"
        t.delete item
      end
      puts " **"

      puts
      t.display
      puts "> #{t.dump_in_order}"
    end

    def self.test_avltree_seed_from_data
      t = AVLTree(String).new
      ["a", "b", "c", "d", "e", "f", "g", "h"].each { |item| t.insert item }
      puts
      puts "After inserting a flat array: individual inserts"
      t.display

      t = AVLTree(String).new ["a", "b", "c", "d", "e", "f", "g", "h"]
      puts
      puts "After inserting a flat array: bulk constructor"
      t.display

      puts
      puts "Moving that back into an ordered double linked list"
      ll = LinkedList(String).new t
      puts ll
    end

    def self.test5
    end

    def self.test6
    end
  end

  ###
  Util.test_avltree_with_primitive_types
  Util.test_avltree_with_objects
  Util.test_avltree_seed_from_data
end
