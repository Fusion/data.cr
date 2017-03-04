require "./spec_helper"

describe CrData do
  describe "AVL Tree" do
    add_items = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    del_items = ["D", "J", "I", "K", "L"]
    t = AVLTree(String).new

    it "can append to an AVL tree while keeping it balanced" do
      add_items.each do |item|
        t.insert item
      end
      t.dump_in_order.should eq " A B C D E F G H I J K L"
    end

    it "can delete from an AVL tree while keeping it balanced" do
      del_items.each do |item|
        t.delete item
      end
      t.dump_in_order.should eq " A B C E F G H"
    end

    it "can enumerate elements" do
      t_s_a = [] of String
      t.each do |item|
        t_s_a << item
      end
      t_s_a.join(",").should eq "A,B,C,E,F,G,H"
    end    
  end

  describe "Map" do
    m0 = Map(String, String).new
    m1 = m0.set("test1", "v:1")
    m2 = m1.set("test2", "v:2")
    m = m2.set("test0", "v:0")
    (3..9).each { |x| m = m.set("test#{x}", "v:#{x}"); }
    it "can add map entries out of order and retrieve them ordered" do
      m.dump.should eq " v:0 v:1 v:2 v:3 v:4 v:5 v:6 v:7 v:8 v:9"
    end

    mu = m.set("test8", "ok")
    mv = mu.set("test3", "ok3")
    mw = mv.set("test5", "ok5")
    mx = mw.set("test6", "ok6")
    it "can update map values" do
      mx.dump.should eq " v:0 v:1 v:2 ok3 v:4 ok5 ok6 v:7 ok v:9"
    end
    
    my = mx.unset("test5")
    my = my.unset("test1")
    my = my.unset("test9")
    my = my.set("test5", "5!")
    it "can delete keys and recreate them" do
      my.dump.should eq " v:0 v:2 ok3 v:4 5! ok6 v:7 ok"
    end

    it "can enumerate elements in key order" do
      keys_a = [] of String
      values_a = [] of String?
      my.each do |entry|
        keys_a <<  entry.key
        values_a << entry.value
      end
      keys_a.join(",").should eq "test0,test2,test3,test4,test5,test6,test7,test8"
      values_a.join(",").should eq "v:0,v:2,ok3,v:4,5!,ok6,v:7,ok"
    end
  end

  describe "Map key-values directly in Tree" do
    t = AVLTree(KVP(String, String)).new
    t.insert(KVP(String, String).new("test1", "v:1"))
    t.insert(KVP(String, String).new("test2", "v:2"))
    t.insert(KVP(String, String).new("test0", "v:0"))
    (3..9).each { |x| t.insert(KVP(String, String).new("test#{x}", "v:#{x}")); }    
    it "can store key values in trees" do
      t.dump_in_order.should eq " v:0 v:1 v:2 v:3 v:4 v:5 v:6 v:7 v:8 v:9"
    end
  end

  describe "Linked List" do
    l = LinkedList(String).new
    l << "a"
    l << "b"
    l << "c"
    l << "d"    
    it "can store values in a linked list" do
      l.to_s.should eq " << a << b << c << d"
    end
  end

  describe "List" do
    #TODO
  end

  describe "Stack" do
    #TODO
  end

  describe "Vector" do
    #TODO
  end
end
