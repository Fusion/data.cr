class Map(K, V)
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
      @value = ""
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

  def dump
    @tree.dump_in_order
  end

  def display
    @tree.display
  end

  def set(key, value)
    # TODO Need find out if copy_path returns upon finding an existing key or not
    # If found, then we do not insert but replace...only value should change
    # Yes, this currently kinda works but seriously the insert() should not be here
    # It is too expensive
    node = KVP(K, V).new(key, value)
    new_root_node, existing_node = @tree.copy_path(node)
    new_tree = AVLTree(KVP(K, V)).new(new_root_node)
    new_tree.insert(node)
    Map(K, V).new(new_tree)
  end
end
