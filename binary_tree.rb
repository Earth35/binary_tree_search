class BinarySearchTree
  attr_reader :array
  attr_accessor :root
  
  def initialize
    @array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    @root = build_tree(@array)
  end
  
  def breadth_first_search(target)
    queue = []
    # check if root is the traget node
    if @root.value == target
      return @root
    else
      queue_children_nodes(@root, queue)
    end
    until queue.empty?  # check queued nodes (First In - First Out), return node if found the target value
      current_node = queue.shift
      if current_node.value == target
        return current_node
      else
        queue_children_nodes(current_node, queue)
      end
    end
    return nil  # return nil if target not present in the tree
  end
  
  private
  
  def build_tree (array, root = nil)
    until array.empty?
      new_value = array.shift
      if !root
        root = Node.new(new_value)  # element under index 0 will always serve as root since we assume that array cannot be sorted
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
      # perform an analogous operation if analyzed element is greater than root's value; duplicates aren't placed
      if root.right.nil?
        root.right = Node.new(value)
      else
        place_node(value, root.right)
      end
    end
  end
  
  def queue_children_nodes (parent, queue)
    # push only existing nodes
    queue.push(parent.left) if parent.left
    queue.push(parent.right) if parent.right
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
puts binary_search_tree.breadth_first_search(67)
