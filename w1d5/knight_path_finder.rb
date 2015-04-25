require_relative '00_tree_node.rb'


class PolyTreeNode

  def trace_path_back
    current_val = self
    path = []
    until current_val.parent == nil
      path << current_val.value
      current_val = current_val.parent
    end
    path << current_val.value

    path.reverse
  end


end

class KnightPathFinder

  attr_reader :starting_node

  def initialize(start_position)
    @starting_node = PolyTreeNode.new(start_position)
    @visited_positions = []
    build_move_tree
  end

  def build_move_tree
    queue = [@starting_node]
    until queue.empty?
      current_node = queue.shift
      new_positions = new_move_positions(current_node.value)
      new_positions.each do |new_position|
        new_node = PolyTreeNode.new(new_position)
        current_node.add_child(new_node)
        queue << new_node
      end
    end

    nil
  end

  def find_path(end_pos)

    @starting_node.dfs(end_pos).trace_path_back
    # find the path!!
  end



  def new_move_positions(pos)
    candidates = KnightPathFinder.valid_moves(pos)
    result = []
    candidates.each do |candidate|
      next if candidate.nil?
      next if @visited_positions.include?(candidate)
      @visited_positions << candidate
      result << candidate
    end

    result
  end

  def self.valid_moves(pos)
    result = []
    offsets = [[2, 1], [2,-1], [-2, 1], [-2, -1]]
    offsets = offsets + offsets.map(&:reverse)
    offsets.each do |offset|
      candidate = dot_sum_arrays(pos, offset)
      if valid?(candidate)
        result << candidate
      end
    end

    result
  end

  def self.valid?(candidate)
    candidate.all? { |coordinate| coordinate.between?(0, 7) }
  end

  private

    def self.dot_sum_arrays(arr1, arr2)
      arr1.map.with_index { |el, i| el + arr2[i]}
    end

end


kpf = KnightPathFinder.new([0, 0])


p kpf.find_path([7, 6])
p kpf.find_path([6, 2])
