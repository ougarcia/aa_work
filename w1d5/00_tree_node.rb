# Implement a TreeNOdeclass

class PolyTreeNode
  attr_reader :parent, :children, :value
  attr_accessor :parent

  def self.create_root
    PolyTreeNode.new
  end

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent_node)
    condition = @parent.nil? || !@parent.children.include?(self)
    @parent.remove_child(self) unless condition
    @parent = parent_node
    condition = @parent.nil? || @parent.children.include?(self)
    @parent.add_child(self) unless condition
  end

  def remove_child(child_to_be_removed)
    raise if !@children.include?(child_to_be_removed)
    @children.delete(child_to_be_removed)
    child_to_be_removed.parent = nil unless child_to_be_removed.parent == nil
  end

  def add_child(child_node)
      @children << child_node
      child_node.parent=(self) unless child_node.parent == self
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if children.empty?
    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result != nil
    end

    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      current_object = queue.shift
      return current_object if current_object.value == target_value
      queue += current_object.children
    end

    nil
  end
end

if __FILE__ == $PROGRAM_NAME

  node1 = PolyTreeNode.new(1)
  node2 = PolyTreeNode.new(2)
  node3 = PolyTreeNode.new(3)

  node2.parent = node1
  node3.parent = node2

  # p node1.dfs(3).value
  # p node1.dfs(2).value
  # p node2.dfs(3).value
end
