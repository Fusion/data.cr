require "../src/crdata/*"

module CRData
  class Util
    def self.test_map
      t = AVLTree(Map::KVP(String, String)).new
      t.insert(Map::KVP(String, String).new("test1", "v:1"))
      t.insert(Map::KVP(String, String).new("test2", "v:2"))
      t.insert(Map::KVP(String, String).new("test0", "v:0"))
      (3..9).each { |x| t.insert(Map::KVP(String, String).new("test#{x}", "v:#{x}")); puts "DUMP: [#{t.dump_in_order}]" }
      puts "tDUMP: [#{t.dump_in_order}]"
      t.display
      puts "After updating tree key 'test8'"
      t.insert(Map::KVP(String, String).new("test8", "v:OK"))
      t.display

      m0 = Map(String, String).new
      m1 = m0.set("test1", "v:1")
      puts "DUMP: [#{m1.dump}]"
      m2 = m1.set("test2", "v:2")
      puts "DUMP: [#{m2.dump}]"
      m = m2.set("test0", "v:0")
      puts "DUMP m : [#{m.dump}]"
      m.display
      puts "DUMP m2: [#{m2.dump}]"
      m2.display
      (3..9).each { |x| m = m.set("test#{x}", "v:#{x}"); puts "DUMP: [#{m.dump}]" }

      puts "#DUMP:"
      puts m.dump
      puts
      puts "#DISPLAY:"
      m.display
      puts
      puts "LOOKUP test8"
      mu = m.set("test8", "ok")
      puts "After Update:"
      mu.display
      mv = mu.set("test3", "ok3")
      mv.display
      mw = mv.set("test5", "ok5")
      mw.display
      mx = mw.set("test6", "ok6")
      mx.display
      puts "While original remains:"
      m.display
      my = mx.unset("test5")
      my = my.unset("test1")
      my = my.unset("test9")
      my = my.set("test5", "5!")
      puts "After removing test5, test1, test9, then adding test5 again:"
      my.display
      puts "While original remains:"
      m.display
    end
  end

  ###
  Util.test_map
end
