module CtgovApi
  class Metadata < ApplicationRecord
    self.table_name = "ctgov_api.metadata"

    validates :name, :data_type, :path, :version, presence: true
  end
end
