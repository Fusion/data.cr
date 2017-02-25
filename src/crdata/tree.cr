class Tree(T)
  include Enumerable(T)
  include Iterable(T)

  class Node(N)
    property data, height, color, left, right, children

    enum Color
      BLACK
      RED
    end

    @data : N
    @left : Node(N)?
    @right : Node(N)?
    @children : Array(Node(N))?
    @height : UInt32
    @color : Color

    def to_s(io)
      io << " [#{@data} (height: #{@height})"
      if @left != nil
        io << " / left: #{@left.not_nil!.data}"
      end
      if @right != nil
        io << " / right: #{@right.not_nil!.data}"
      end
      io << "]"
      if @left != nil
        puts @left
      end
      if @right != nil
        puts @right
      end
    end

    def initialize
      initialize nil
    end

    def initialize(@data : N)
      @left = nil
      @right = nil
      @children = nil
      @color = Color::BLACK
      @height = 1_u32
    end

    def initialize(cloned : Node(N))
      # TODO clone data
      @data = cloned.data
      @left = cloned.left
      @right = cloned.right
      @children = cloned.children
      @color = cloned.color
      @height = cloned.height
    end

    def initialize(transplant : Node(N), template : Node(N))
      @data = transplant.data
      @left = template.left
      @right = template.right
      @children = template.children
      @color = template.color
      @height = template.height
    end
  end

  property root_node
  @root_node : Node(T)?

  def to_s(io)
    io.<< @root_node
  end

  def dump
    # For now, NOOP
  end

  def dump_in_order_(node)
    acc! = ""
    if node != nil
      acc = dump_in_order_ node.not_nil!.left
      acc = "" if acc == nil
      acc! = acc.not_nil!
      acc! += " #{node.not_nil!.data}"
      acc! += dump_in_order_ node.not_nil!.right
    end
    acc!
  end

  def dump_in_order
    dump_in_order_ @root_node
  end

  # Yield cannot recurse! Damn...need to unroll the whole business
  # Not too happy here as this means no streaming...
  def each
    # Let's maintain a stack of traversed nodes...
    ll = LinkedList(Node(T)).new
    cur_node = @root_node
    loop do
      if cur_node == nil # Found leftmost node -- go back up
        break if ll.empty?
        cur_node = ll.in_place_pop
        yield cur_node.not_nil!.data
        cur_node = cur_node.not_nil!.right
      else # Keep digging
        ll.add cur_node
        cur_node = cur_node.not_nil!.left
      end
    end
  end

  def initialize
    @root_node = nil
  end
end
