module Ctgov
  class V1Mapping < ApplicationRecord
    self.table_name = "support.ctgov_mappings"

    # connect to aact-core database
    establish_connection :external

    belongs_to :ctgov_metadata,
      class_name: "Ctgov::V1ApiMetadata",
      foreign_key: "ctgov_metadata_id",
      optional: true

    validates :table_name, :field_name, :api_path, presence: true
  end
end
