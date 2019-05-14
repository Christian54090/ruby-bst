class Bst

  def initialize(head)
    @head = Node.new(head)
  end

  def method_missing(method_name, *args)
    if @head.methods.include?(method_name)
      @head.send(method_name, *args)
    else
      super
    end
  end

  def each
    tree = @head.next_val([]).to_enum
    block_given? ? tree.each{ |e| yield e } : tree
  end

  class Node
    attr_accessor :data, :left, :right

    def initialize(data)
      @data = data
    end

    def insert(n)
      if n > @data
        @right ? @right.insert(n) : @right = Node.new(n)
      else
        @left ? @left.insert(n) : @left = Node.new(n)
      end
    end

    def next_val(tree)
      @left.next_val(tree)  if @left
      tree << @data
      @right.next_val(tree) if @right
      tree
    end
  end
end
