class Stack(T)
  include Enumerable(T)
  include Iterable(T)

  getter ll
  @ll : LinkedList(T)

  def to_s(io)
    @ll.to_s_reverse io
  end

  def initialize
    @ll = LinkedList(T).new
  end

  def initialize(items : Array(T))
    @ll = LinkedList(T).new items
  end

  def initialize(other_ll : LinkedList(T))
    @ll = other_ll
  end

  def initialize(other : Stack(T), item : T)
    @ll = LinkedList(T).new other.ll, item
  end

  def each
    @ll.each_reverse { |x| yield x }
  end

  def empty?
    @ll.empty?
  end

  def pop? : {T?, Stack(T)}
    v, new_ll = @ll.pop?
    {v, Stack(T).new(new_ll.not_nil!)}
  end

  def pop : {T?, Stack(T)}
    v, new_ll = @ll.pop
    {v, Stack(T).new(new_ll.not_nil!)}
  end

  def push(item : T)
    Stack(T).new(self, item)
    # @ll << element
  end

  def <<(item : T)
    push item
  end

  def +(item : T)
    push item
  end
end
