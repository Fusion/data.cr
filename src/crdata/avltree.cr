class AVLTree(T)
  include Enumerable(T)
  include Iterable(T)
  #
  # # An AVL Tree will tolerate a balance factor no greater than 1
  # # Balance Factor = abs((leftmost - root) - (rightmost - root))
  #
  # # Achieve thru four rotation types: left, right, l-r, r-l
  #

  @tree : Tree(T)

  delegate display, to: @tree
  delegate dump, to: @tree
  delegate dump_in_order, to: @tree
  delegate to_s, to: @tree

  # When capturing blocks are involved, the delegate macro cannot work...
  def each
    @tree.each do |x|
      yield x
    end
  end

  def initialize
    @tree = Tree(T).new
  end

  # This is _very_ easy to perform with an AVL Tree
  # The data structure being passed needs to be sorted and random access though
  def initialize(source_array : Array(T))
    @tree = Tree(T).new
    @tree.root_node = seed_(source_array, 0, source_array.size - 1)
  end

  # Create a tree with pre populated nodes
  def initialize(root_node : Tree::Node(T)?)
    @tree = Tree(T).new
    @tree.root_node = root_node
  end

  def seed_(source_array, first, last)
    return nil if first > last
    pivot = ((last + first) / 2).to_i32
    cur_node = Tree::Node(T).new(source_array[pivot])
    cur_node.left = seed_(source_array, first, pivot - 1)
    cur_node.right = seed_(source_array, pivot + 1, last)
    cur_node
  end

  # Tree
  # Balanced Search Tree: compare
  def insert(data : T)
    @tree.root_node = insert_(Tree::Node(T).new(data), @tree.root_node)
  end

  def insert_(new_node : Tree::Node(T), cur_node : Tree::Node(T)?)
    return new_node if cur_node == nil

    cur_node! = cur_node.not_nil!
    case new_node.data <=> cur_node!.data
    when -1
      cur_node!.left = insert_(new_node, cur_node!.left)
    when 1
      cur_node!.right = insert_(new_node, cur_node!.right)
    else
      # same... return unmolested if dumb or updated otherwise
      return Tree::Node(T).new(new_node, cur_node!)
    end

    hl = height_(cur_node!.left)
    hr = height_(cur_node!.right)
    cur_node!.height = 1_u32 + Math.max(hl, hr)
    distance = (hl - hr).to_i32
    # distance (aka balance factor) should never exceed 1 in an AVL tree
    case distance
    when .< -1
      case new_node.data <=> cur_node!.right.not_nil!.data
      when -1
        cur_node!.right = right_rotate(cur_node!.right.not_nil!)
        cur_node! = left_rotate(cur_node!)
      when 1
        cur_node! = left_rotate(cur_node!)
      end
    when .> 1
      case new_node.data <=> cur_node!.left.not_nil!.data
      when -1
        cur_node! = right_rotate(cur_node!)
      when 1
        cur_node!.left = left_rotate(cur_node!.left.not_nil!)
        cur_node! = right_rotate(cur_node!)
      end
    end

    cur_node!
  end

  def delete(data : T)
    @tree.root_node = delete_(Tree::Node(T).new(data), @tree.root_node)
  end

  def delete_(del_node : Tree::Node(T), cur_node : Tree::Node(T)?)
    return cur_node if cur_node == nil

    cur_node! = cur_node.not_nil!
    case del_node.data <=> cur_node!.data
    when -1
      cur_node!.left = delete_(del_node, cur_node!.left)
    when 1
      cur_node!.right = delete_(del_node, cur_node!.right)
    else
      # Found it
      # Three scenario:
      # #1: we have no children. Easy.
      # #2: we have only one child. Simply erase current node with that child
      # #3: we need to keep going using next in line
      children = (cur_node!.left != nil ? 1 : 0) + (cur_node!.right != nil ? 1 : 0)
      case children
      when 0
        return nil
      when 1
        cur_node! = (cur_node!.left != nil ? cur_node!.left : cur_node!.right).not_nil!
      else
        # find next in line
        next_node = cur_node!.right
        while next_node.not_nil!.left != nil
          next_node = next_node.not_nil!.left
        end
        cur_node! = Tree::Node(T).new(next_node.not_nil!, cur_node!)
        cur_node!.right = delete_(next_node.not_nil!, cur_node!.right)
      end
    end

    # uncomment to bypass rebalancing: return cur_node! if 1 == 1
    # So, should we rebalance?
    hl = height_(cur_node!.left)
    hr = height_(cur_node!.right)
    cur_node!.height = 1_u32 + Math.max(hl, hr)
    distance = (hl - hr).to_i32
    case distance
    when .< -1
      right_distance = (height_(cur_node!.right.not_nil!.left) - height_(cur_node!.right.not_nil!.right)).to_i32
      case right_distance
      when .<= 0
        cur_node! = left_rotate(cur_node!)
      else
        cur_node!.right = right_rotate(cur_node!.right.not_nil!)
        cur_node! = left_rotate(cur_node!)
      end
    when .> 1
      left_distance = (height_(cur_node!.left.not_nil!.left) - height_(cur_node!.left.not_nil!.right)).to_i32
      case left_distance
      when .>= 0
        cur_node! = right_rotate(cur_node!)
      else
        cur_node!.left = left_rotate(cur_node!.left.not_nil!)
        cur_node! = right_rotate(cur_node!)
      end
    end

    cur_node!
  end

  def left_rotate(node : Tree::Node(T))
    nr = node.right.not_nil!
    nl = nr.left
    nr.left = node
    node.right = nl
    node.height = 1_u32 + Math.max(height_(node.left), height_(node.right))
    nr.height = 1_u32 + Math.max(height_(nr.left), height_(nr.right))
    nr
  end

  def right_rotate(node : Tree::Node(T))
    nl = node.left.not_nil!
    nr = nl.right
    nl.right = node
    node.left = nr
    node.height = 1_u32 + Math.max(height_(node.left), height_(node.right))
    nl.height = 1_u32 + Math.max(height_(nl.left), height_(nl.right))
    nl
  end

  def height_(node)
    return 0 if node == nil
    node.not_nil!.height
  end

  def copy_path(data : T) : {Tree::Node(T)?, Tree::Node(T)?}
    node = @tree.root_node
    copy_root_node = Tree::Node(T).new(node.not_nil!) if node != nil
    cur_node = copy_root_node
    loop do
      return {copy_root_node, nil} if node == nil

      case data <=> node.not_nil!.data
      when 1
        cur_node.not_nil!.right = Tree::Node(T).new(node.not_nil!.right.not_nil!) if node.not_nil!.right != nil
        node = node.not_nil!.right
        cur_node = cur_node.not_nil!.right
      when -1
        cur_node.not_nil!.left = Tree::Node(T).new(node.not_nil!.left.not_nil!) if node.not_nil!.left != nil
        node = node.not_nil!.left
        cur_node = cur_node.not_nil!.left
      else
        return {copy_root_node, node}
      end
    end
  end

  # Tree
  # Balanced Search Tree: compare
  def search(data : T) : Tree::Node(T)?
    node = @tree.root_node
    loop do
      return nil if node == nil || node.not_nil!.data == nil
      case data <=> node.not_nil!.data
      when 1
        node = node.not_nil!.right
      when -1
        node = node.not_nil!.left
      else
        return node
      end
    end
  end
end
