class QueryExecutor < ES::Configuration
		INDEX_NAME = "college"
    	INDEX_TYPES = [COLLEGE_DETAILS = "campus_details", CAMPUS_DRIVES = "campus_drives"]

		def initialize
			@client = get_client			
		end

		def execute_college_drive(body=nil)
			@body = body if body.present?
			openings_hash = @client.search :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:body=>@body			
		end

		def execute_college(body)
			@body = body if body.present?
			companies_hash = @client.search :index=>INDEX_NAME,:type=>COLLEGE_DETAILS,:body=>@body
		end
end