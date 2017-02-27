class Map(K, V)
  include Enumerable(K)

  class KVP(K, V)
    include Comparable(KVP)

    property key, value

    def to_s(io)
      # io << "#{key} => #{@value}"
      # io << "#{@value} - #{@value.object_id}"
      io << "#{@value}"
    end

    def initialize(@key : K, @value : V)
    end

    def initialize(@key : K)
      @value = nil
    end

    def <=>(other : KVP(K, V))
      @key <=> other.@key
    end
  end

  def initialize(@tree)
  end

  def initialize
    @tree = AVLTree(KVP(K, V)).new
  end

  def each(&block : KVP(K, V) ->)
    @tree.each(&block)
  end

  def dump
    @tree.dump_in_order
  end

  def display
    @tree.display
  end

  def set(key : K, value : V)
    node = KVP(K, V).new(key, value)
    new_root_node, existing_node = @tree.copy_path(node)
    new_tree = AVLTree(KVP(K, V)).new(new_root_node)
    new_tree.insert(node)
    Map(K, V).new(new_tree)
  end

  def unset(key : K)
    node = KVP(K, V).new(key)
    new_root_node, existing_node = @tree.copy_path(node)
    new_tree = AVLTree(KVP(K, V)).new(new_root_node)
    new_tree.delete(node)
    Map(K, V).new(new_tree)
  end
end

alias SortedMap = Map
