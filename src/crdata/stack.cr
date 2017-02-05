class Stack(T)
  include Enumerable(T)
  include Iterable(T)

  getter ll
  @ll : LinkedList(T)

  def to_s(io)
    @ll.to_s io
  end

  def initialize
    @ll = LinkedList(T).new
  end

  def initialize(items : Array(T))
    @ll = LinkedList(T).new items, reverse: true
  end

  def initialize(other_ll : LinkedList(T))
    @ll = other_ll
  end

  def initialize(other : Stack(T), item : T)
    @ll = LinkedList(T).new item, other.ll
  end

  def each
    @ll.each { |x| yield x }
  end

  def empty?
    @ll.empty?
  end

  def pop? : {T?, Stack(T)}
    {ll.head?, Stack(T).new @ll.tail?}
  end

  def pop : {T?, Stack(T)}
    {@ll.head, Stack(T).new @ll.tail}
  end

  def push(item : T)
    Stack(T).new(self, item)
  end

  def <<(item : T)
    push item
  end

  def +(item : T)
    push item
  end
end
