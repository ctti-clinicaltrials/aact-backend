class DataMappingService
  def initialize(mapping)
    @mapping = mapping
  end

  def data_mapping
    flattened_data = []

    @mapping.each do |map|
      root = map["root"] # root is the starting path

      # If there is a flatten attribute, combine it with the root
      if map["flatten"]
        root = (root || []) + map["flatten"]
      end

      map["columns"].each do |column|
        full_path = build_full_path(root, column["value"])

        # Store the table, field, API path, and conversion info if available
        flattened_data << {
          table: map["table"],
          field: column["name"],
          api_path: full_path,
          convert_to: column["convert_to"] # You can add nil or empty string if this doesn't exist
        }
      end

      # Recursively process nested mappings if any
      if map["children"]
        flattened_data += process_children(map["children"], root)
      end
    end

    flattened_data
  end

  private

  def build_full_path(root, value)
    full_path = root ? root.dup : []

    if value.is_a?(Array)
      # Handle $parent references
      value.each do |v|
        if v == "$parent"
          full_path.pop # Remove the last element (going "up" one level)
        else
          full_path << v
        end
      end
    else
      full_path << value
    end

    full_path
  end

  def process_children(children, parent_root)
    flattened_data = []

    children.each do |child|
      root = child["root"] || parent_root # Inherit parent's root if child root is nil

      # Handle the flatten attribute if it exists
      if child["flatten"]
        root = (root || []) + child["flatten"]
      end

      child["columns"].each do |column|
        full_path = build_full_path(root, column["value"])

        # Store the table, field, API path, and conversion info if available
        flattened_data << {
          table: child["table"],
          field: column["name"],
          api_path: full_path,
          convert_to: column["convert_to"] # You can add nil or empty string if this doesn't exist
        }
      end

      # Recursively process nested children
      if child["children"]
        flattened_data += process_children(child["children"], root)
      end
    end

    flattened_data
  end
end
