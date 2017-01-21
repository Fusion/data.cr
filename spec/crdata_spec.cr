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
  end
end
