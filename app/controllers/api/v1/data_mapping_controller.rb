module Api
  module V1
    class DataMappingController < ApplicationController
      def index
        service = DataMappingService.new(load_mapping)
        data = service.data_mapping
        render json: data
      end


      private

      def load_mapping
        location = Rails.root.join("lib", "aact", "mapping.json")
        content = File.read(location)
        JSON.parse(content)
      end
    end
  end
end
