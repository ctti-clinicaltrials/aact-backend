class MetadataFlattener
  def initialize(metadata)
    @metadata = metadata
  end

  def flatten
    flatten_json(@metadata)
  end

  private

  def flatten_json(node, parent_path = [])
    flattened_data = []

    # metadata returns an array of objects
    if node.is_a?(Array)
      node.each do |child|
        flattened_data += flatten_json(child, parent_path)
      end
    elsif node["children"] # Current node has children, so it's not a leaf node
      current_path = parent_path + [ node["name"] ]
      node["children"].each do |child|
        flattened_data += flatten_json(child, current_path)
      end
    else
      # should be a leaf node
      flattened_data << {
        name: node["name"],
        type: node["type"],
        piece: node["piece"],
        source_type: node["sourceType"],
        synonyms: node["synonyms"],
        label: node.dig("dedLink", "label"),
        url: node.dig("dedLink", "url"),
        section: parent_path[0],
        module: parent_path[1],
        path: parent_path + [ node["name"] ]  # Full path to this node
      }
    end

    flattened_data
  end
end
