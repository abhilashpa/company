require 'elasticsearch'

module ES
  class Configuration
    ELASTICSEARCH_SETTING = YAML::load(File.open("#{Rails.root}/config/elasticsearch_settings.yml"))
    INDEX_NAME = "company"
    INDEX_TYPES = [COMPANY_DETAIL = "company_details",COMPANY_OPENNING ="openings"]

    def initialize
      @client_obj = get_client
    end

    def self.get_username
      ELASTICSEARCH_SETTING["es_auth_username"]
    end

    def self.get_password
      ELASTICSEARCH_SETTING["es_auth_password"]
    end

    def get_client
      ::Elasticsearch::Client.new(
        :hosts=> [{
                    :host=> "localhost",
                    :port=> "9200",
                    #:user=> ElasticsearchConfiguration.get_username,
                    #:password=> ElasticsearchConfiguration.get_password
        }]
      )
    end

    def create_mapping
      company_map = {
        name: {
          type: "text" },
        established: {
          type: "integer"},
        no_of_employess:{
          type: "integer"},
        headquater: {
          type: "keyword"},
        description: {
          type: "text"},
        business_nature: {
          type: "text"},
        contact_details:{
          type: "nested",
          properties:{
              email_1:{
                type: "keyword" },
              email_2:{
                type: "keyword" },
              phone_1:{
                type: "keyword" },
              phone_2:{
                type: "keyword" }
          }
        }

      }

      openning_map = {
        position: {
          type: "text"
          },
        department: {
          type: "text"
          },
        no_of_openings: {
          type: "integer"
          },
        opening_type: {
          type: "text"
          },
        package_upper: {
          type: "integer"
          },
        package_lower: {
          type: "integer"
          },
        location: {
          type: "geo_point"
          },
        contact_details:{
           type: "nested",
             properties:{
               email_1: { type: "keyword" },
               email_2: { type: "keyword" },
               phone_1: { type: "keyword" },
               phone_2: { type: "keyword" }
             }
         }
      }

      @client_obj.indices.create index: INDEX_NAME,
      body: {
        settings:{
          "number_of_shards": 2,
          "number_of_replicas": 0
        },
        mappings: {
          COMPANY_DETAIL.to_s => {
            properties: company_map
          },
          COMPANY_OPENNING.to_s =>  {
            _parent: { type: COMPANY_DETAIL },
            properties: openning_map
          }
        }
      }
    end

  end
end
