module Api
  module V1
    class DataMappingController < ApplicationController
      def index
        mappings = Ctgov::V1Mapping.joins(:ctgov_metadata)
        render json: mappings.to_json(include: :ctgov_metadata)
      end
    end
  end
end
