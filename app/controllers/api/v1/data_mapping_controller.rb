module Api
  module V1
    class DataMappingController < ApplicationController
      def index
        mappings = Ctgov::V1Mapping.fetch_with_metadata
        render json: normalize_response(mappings)
      end

      private

      def normalize_response(mappings)
        mappings.map do |mapping|
          {
            aact_id: mapping.id,
            aact_table: mapping.table_name,
            aact_field: mapping.field_name,
            aact_active: mapping.active,
            aact_api_path: mapping.api_path,
            aact_ctgov_metadata_id: mapping.ctgov_metadata_id,
            aact_created_at: mapping.created_at,
            aact_updated_at: mapping.updated_at,
            ctgov_id: mapping.ctgov_metadata.id,
            ctgov_version: mapping.ctgov_metadata.version,
            ctgov_section: mapping.ctgov_metadata.section,
            ctgov_module: mapping.ctgov_metadata.module,
            ctgov_path: mapping.ctgov_metadata.path,
            ctgov_field: mapping.ctgov_metadata.name,
            ctgov_data_type: mapping.ctgov_metadata.data_type,
            ctgov_field_name: mapping.ctgov_metadata.piece,
            ctgov_source_type: mapping.ctgov_metadata.source_type,
            ctgov_synonyms: mapping.ctgov_metadata.synonyms,
            ctgov_doc_url: mapping.ctgov_metadata.url,
            ctgov_doc_url_label: mapping.ctgov_metadata.label,
            ctgov_created_at: mapping.ctgov_metadata.created_at,
            ctgov_updated_at: mapping.ctgov_metadata.updated_at
          }
        end
      end
    end
  end
end
