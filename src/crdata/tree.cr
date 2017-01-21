class Tree(T)
  class Node(N)
    property data, height, left, right

    @data : N
    @left : Node(N) | Nil
    @right : Node(N) | Nil
    @height : UInt32

    def to_s(io)
      io << " [#{@data} (height: #{@height}"
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
      @height = 1_u32
    end

    def initialize(transplant : Node(N), template : Node(N))
      @data = transplant.data
      @left = template.left
      @right = template.right
      @height = template.height
    end
  end

  property root_node
  @root_node : Node(T) | Nil

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

  def initialize
    @root_node = nil
  end
end
