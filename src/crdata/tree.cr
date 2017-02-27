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

    def each(&block : N ->)
      if l = @left
        l.each(&block)
      end
      yield @data
      if r = @right
        r.each(&block)
      end
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

  def each(&block : T ->)
    if @root_node != nil
      @root_node.not_nil!.each(&block)
    end
  end

  def initialize
    @root_node = nil
  end
end
