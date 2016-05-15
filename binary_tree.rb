class BinarySearchTree
  attr_reader :array
  attr_accessor :root
  
  def initialize
    @array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    @root = build_tree(@array)
  end
  
  def breadth_first_search (target) # BFS
    queue = []
    # check if root is the traget node
    if @root.value == target
      return @root
    else
      push_children_nodes(@root, queue)
    end
    until queue.empty?  # check queued nodes (First In - First Out), return node if found the target value
      current_node = queue.shift
      if current_node.value == target
        return current_node
      else
        push_children_nodes(current_node, queue)
      end
    end
    return nil  # return nil if target not present in the tree
  end
  
  def depth_first_search (target) # iterative DFS
    stack = []
    # check the root node
    if @root.value == target
      return @root
    else
      push_children_nodes(@root, stack)
    end
    until stack.empty?  # start checking nodes from the stack
      current_node = stack.pop
      if current_node.value == target
        return current_node
      else
        push_children_nodes(current_node, stack)
      end
    end
    return nil # return nil if target not found
  end
  
  def dfs_rec (target, current_node = @root) # recursive DFS
    return current_node if current_node.value == target # returns own value if equal to target
    left_child = current_node.left ? dfs_rec(target, current_node.left) : nil
    # return the value of child node if equal to target
    if left_child
      return left_child if left_child.value == target
    end
    right_child = current_node.right ? dfs_rec(target, current_node.right) : nil
    if right_child
      return right_child if right_child.value == target
    end
  end
  
  private
  
  def build_tree (array, root = nil)
    until array.empty?
      new_value = array.shift
      if !root
        root = Node.new(new_value)  # element under index 0 will always serve as root since we assume the array cannot be sorted
      else
        place_node(new_value, root)
      end
    end
    return root
  end

  def place_node (value, root)
    if value < root.value
      if root.left.nil?  # add element as direct left node if such sub-node doesn't exist
        root.left = Node.new(value)
      else  # otherwise, execute method recursively until the element is matched
        place_node(value, root.left)
      end
    elsif value > root.value
      # perform an analogous operation if analyzed element is greater than root value; duplicates aren't placed
      if root.right.nil?
        root.right = Node.new(value)
      else
        place_node(value, root.right)
      end
    end
  end
  
  def push_children_nodes (parent, array)
    # push only existing nodes; array is a queue (BFS) or a stack (DFS)
    array.push(parent.right) if parent.right
    array.push(parent.left) if parent.left
  end
  
  class Node
    attr_reader :value
    attr_accessor :left, :right
    def initialize (value)
      @value = value
      @left = nil
      @right = nil
    end
  end
end

binary_search_tree = BinarySearchTree.new
puts "BFS:"
puts binary_search_tree.breadth_first_search(67)
puts "Iterative DFS:"
puts binary_search_tree.depth_first_search(67)
puts "Recursive DFS:"
puts binary_search_tree.dfs_rec(67)