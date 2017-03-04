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

