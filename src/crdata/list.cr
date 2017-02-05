class List(T)
  getter ll
  @ll : LinkedList(T)

  def to_s(io)
    @ll.to_s io
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

  def initialize(item : T, other : List(T))
    @ll = LinkedList(T).new item, other.ll
  end

  def empty?
    @ll.empty?
  end

  def head?
    @ll.head?
  end

  def head
    @ll.head
  end

  def tail?
    List(T).new @ll.tail?
  end

  def tail
    List(T).new @ll.tail
  end

  def clone_with_(item : T)
    List(T).new(item, self)
  end

  def push(element : T)
    raise "Lists are meant to be built through inserted elements; not appended."
  end

  def <<(element : T)
    push element
  end
end

class Object
  def +(other : List)
    other.clone_with_ self
  end
end
