class Node
  attr_reader :value, :left, :right
  def initialize (value, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
end

def build_tree (array)
  return Node.new(array[0]) if array.length == 1
  middle = array[array.length/2]
  left = array[0..array.length/2-1]
  right = array[array.length/2+1..-1]
  if right.empty?
    return node = Node.new(middle, build_tree(left))
  else
    return node = Node.new(middle, build_tree(left), build_tree(right))
  end
end

p sorted_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort
root = build_tree(sorted_array)
