class DataMappingService
  def initialize(mapping)
    @mapping = mapping
  end

  def data_mapping
    process_mapping(@mapping)
  end

  def process_mapping(mappings, parent_root = nil)
    mappings.each do |map|
      parent_root ||= map["root"] # Set the parent root if it's nil
      root = map["root"] || [] # root is the starting path

      # If there is a flatten attribute, combine it with the root
      if map["flatten"]
        root = (root || []) + map["flatten"]
      end

      map["columns"].each do |column|
        full_path_array = build_full_path(root, column["value"])
        api_path = full_path_array.join(".")

        metadata = CtgovApi::Metadata.find_by(path: api_path)

        CtgovApi::Mapping.create(
          table_name: map["table"],
          field_name: column["name"],
          api_path: api_path,
          ctgov_api_metadata_id: metadata&.id, # Link to metadata using foreign key
          active: true
        )
      end

      if map["children"]
        process_children(map["children"], root)
      end
    end
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
    children.each do |child|
      root = parent_root.dup if parent_root
      root += child["root"] if child["root"]
      root += child["flatten"] if child["flatten"]

      child["columns"].each do |column|
        full_path_array = build_full_path(root, column["value"])
        api_path = full_path_array.join(".")

        metadata = CtgovApi::Metadata.find_by(path: api_path)

        CtgovApi::Mapping.create(
          table_name: child["table"],
          field_name: column["name"],
          api_path: api_path,
          ctgov_api_metadata_id: metadata&.id, # Link to metadata using foreign key
          active: true
        )
      end

      # Recursively process nested children
      if child["children"]
        process_children(child["children"], root)
      end
    end
  end
end
