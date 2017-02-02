class LinkedList(V)
  include Enumerable(V)
  include Iterable(V)

  class Node(T)
    property n, p, v
    @n : Node(T) | Nil
    @p : Node(T) | Nil
    @v : T | Nil

    def to_s(io)
      io << "#{@v}"
    end

    def initialize
      @n = nil
      @p = nil
      @v = nil
    end

    def initialize(@v)
      @n = nil
      @p = nil
    end
  end

  def to_s(io)
    io << "Forward: "
    node = @head
    while node != nil && node.not_nil!.v != nil
      io << " - #{node.not_nil!.v}"
      node = node.not_nil!.n
    end
    io << "\nBackward: "
    node = @tail
    loop do
      node = node.not_nil!.p
      break if node == nil
      io << " - #{node.not_nil!.v}"
    end
    io << "\n"
  end

  def initialize
    @head = Node(V).new
    @tail = @head
  end

  def initialize(iterable)
    initialize
    iterable.each { |x| add(x) }
  end

  def empty?
    @head == @tail
  end

  def add(item : V | Nil)
    @tail.v = item
    node = Node(V).new
    node.p = @tail
    @tail.n = node
    @tail = node
  end

  def <<(item : V)
    add item
  end

  def pop
    raise "Empty list!" if @head == @tail
    @tail = @tail.p.not_nil!
    @tail.v
  end

  def get(idx) : V | Nil
    return get_forward(idx) if idx >= 0
    get_backward(-idx)
  end

  def get_forward(idx) : V | Nil
    return @head.v if idx == 0
    node = @head
    idx.times do
      raise "OutOfBounds" if node.not_nil!.n == nil
      node = node.not_nil!.n
    end
    raise "OutOfBounds" if node.not_nil!.v == nil
    node.not_nil!.v
  end

  def get_backward(idx) : V | Nil
    node = @tail
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
end
