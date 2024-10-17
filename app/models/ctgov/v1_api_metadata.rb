module Ctgov
  class V1ApiMetadata < ApplicationRecord
    self.table_name = "support.ctgov_metadata"

    # connect to aact-core database
    establish_connection :external

    has_many :v1_mappings,
      class_name: "Ctgov::V1Mapping",
      foreign_key: "ctgov_metadata_id"
  end
end
