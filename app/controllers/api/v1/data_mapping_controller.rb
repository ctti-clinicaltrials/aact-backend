module Api
  module V1
    class DataMappingController < ApplicationController
      def index
        mappings = CtgovApi::Mapping.joins(:ctgov_api_metadata)
        render json: mappings.to_json(include: :ctgov_api_metadata)
      end
    end
  end
end
