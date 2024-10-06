module CtgovApi
  class Mapping < ActiveRecord::Base
    self.table_name = "ctgov_api.mappings"

    belongs_to :ctgov_api_metadata,
      class_name: "CtgovApi::Metadata",
      foreign_key: "ctgov_api_metadata_id",
      optional: true

    validates :table_name, :field_name, :api_path, presence: true
  end
end
