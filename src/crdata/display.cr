# Inspired by these clever folks:
# http://stackoverflow.com/questions/4965335/how-to-print-binary-tree-diagram
#
class Tree(T)
  def display
    display_ [@root_node], 0, maxdepth @root_node
  end

  def display_(nodes, level, depth)
    return if nodes.size == 0
    floor = depth - level
    return if floor == 0
    edge_lines = 2 ** Math.max(floor - 1, 0)
    first_spaces = 2 ** floor - 1
    between_spaces = 2 ** (floor + 1) - 1
    # puts "E=#{edge_lines} F=#{first_spaces} B=#{between_spaces}"
    print " " * first_spaces
    new_nodes = [] of Node(T) | Nil
    nodes.each do |node|
      if node != nil
        print node.not_nil!.data
        new_nodes << node.not_nil!.left
        new_nodes << node.not_nil!.right
      else
        new_nodes << nil
        new_nodes << nil
        print " "
      end
      print " " * between_spaces
    end
    puts
    (1..edge_lines).each do |i|
      nodes.each do |node|
        print " " * (first_spaces - i)
        if node == nil
          print " " * (edge_lines + edge_lines + i + 1)
          next
        end
        if node.not_nil!.left != nil
          print "/"
        else
          print " "
        end
        print " " * (i + i - 1)
        if node.not_nil!.right != nil
          print "\\"
        else
          print " "
        end
        print " " * (edge_lines + edge_lines - i)
      end
      puts
    end
    display_ new_nodes, level + 1, depth
  end

  def maxdepth(node)
    return 0 if node == nil
    1 + Math.max maxdepth(node.not_nil!.left), maxdepth(node.not_nil!.right)
  end
end
