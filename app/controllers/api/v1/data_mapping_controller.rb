module Api
  module V1
    class DataMappingController < ApplicationController
      # def index
      #   # service = DataMappingService.new(load_mapping)
      #   # service.data_mapping
      #   mappings = CtgovApi::Mapping.joins(:ctgov_api_metadata)
      #                               .select("ctgov_api.mappings.*, ctgov_api.metadata.label, ctgov_api.metadata.url")
      #   render json: mappings.includes(:ctgov_api_metadata)
      # end
      def index
        mappings = CtgovApi::Mapping.includes(:ctgov_api_metadata).all
        render json: mappings.to_json(include: :ctgov_api_metadata)
      end


      private

      def load_mapping
        location = Rails.root.join("lib", "aact", "outcomes.json")
        content = File.read(location)
        JSON.parse(content)
      end
    end
  end
end
