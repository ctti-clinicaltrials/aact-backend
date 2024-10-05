module Api
  module V1
    class DataMappingController < ApplicationController
      def index
        data = { "message": "Hello, world!" }
        render json: data
      end
    end
  end
end
