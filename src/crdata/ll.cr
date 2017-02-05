#
# This is a helper, **mutable** data structure!
#
class LinkedList(V)
  include Enumerable(V)
  include Iterable(V)

  class Node(T)
    property n, p, v
    @n : Node(T)?
    @p : Node(T)?
    @v : T?

    def to_s(io)
      io << "#{@v}"
    end

    def initialize
      @n = nil
      @p = nil
      @v = nil
    end

    def initialize(@v : T)
      @n = nil
      @p = nil
    end
  end

  property list_head, list_tail
  @list_head : Node(V)
  @list_tail : Node(V)

  def to_s(io)
    full_debug = false
    io << "Forward: " if full_debug
    node = @list_head
    while node != nil && node.not_nil!.v != nil
      io << " << #{node.not_nil!.v}"
      node = node.not_nil!.n
    end
    return if !full_debug

    io << "\nBackward: "
    node = @list_tail
    loop do
      node = node.not_nil!.p
      break if node == nil
      io << " >> #{node.not_nil!.v}"
    end
    io << "\n"
  end

  def initialize
    @list_head = Node(V).new
    @list_tail = @list_head
  end

  def initialize(iterable)
    initialize
    iterable.each { |x| add(x) }
  end

  def initialize(other : LinkedList(V))
    @list_head = other.list_head
    @list_tail = other.list_tail
  end

  def initialize(item : V, other : LinkedList(V))
    node = Node(V).new item
    node.n = other.list_head
    @list_head = node
    @list_tail = other.list_tail
  end

  def each
    node = @list_head
    while node != nil && node.not_nil!.v != nil
      yield node.not_nil!.v.not_nil!
      node = node.not_nil!.n
    end
  end

  def empty?
    @list_head == @list_tail
  end

  def add(item : V?)
    @list_tail.v = item
    node = Node(V).new
    node.p = @list_tail
    @list_tail.n = node
    @list_tail = node
  end

  def <<(item : V)
    add item
  end

  def pop
    raise "Empty list!" if empty?
    @list_tail = @list_tail.p.not_nil!
    @list_tail.v
  end

  def get(idx) : V?
    return get_forward(idx) if idx >= 0
    get_backward(-idx)
  end

  def get_forward(idx) : V?
    return @list_head.v if idx == 0
    node = @list_head
    idx.times do
      raise "OutOfBounds" if node.not_nil!.n == nil
      node = node.not_nil!.n
    end
    raise "OutOfBounds" if node.not_nil!.v == nil
    node.not_nil!.v
  end

  def get_backward(idx) : V?
    node = @list_tail
    idx.times do
      raise "OutOfBounds" if node.not_nil!.p == nil
      node = node.not_nil!.p
    end
    node.not_nil!.v
  end

  def get_first
    get_forward 0
  end

  def get_last
    get_backward 1
  end

  def head?
    return nil if empty?
    get_first
  end

  def head
    raise "OutOfBounds" if empty?
    head?
  end

  def tail?
    new_ll = LinkedList.new self
    return new_ll if empty?
    new_ll.list_head = @list_head.not_nil!.n.not_nil!
    new_ll
  end

  def tail
    raise "OutOfBounds" if @list_head.not_nil!.n == nil
    tail?
  end
end
