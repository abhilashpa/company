module Search
	class SearchBase
		def initialize(query_string,from=0,sort_by=nil,city_filter=nil,positions=nil,openings_search_fields=nil,companies_search_fields=nil)
			@keyword = query_string					
			@openings_search_fields = openings_search_fields
			@companies_search_fields = companies_search_fields		
			@query_constructor = QueryConstructor.new(@keyword,from,sort_by,city_filter,positions,@openings_search_fields,@companies_search_fields)			
			@query_executor = QueryExecutor.new
		end

		def search
			body = @query_constructor.create
			puts "#{body.inspect}"
			campus_drives = @query_executor.execute_college_drive(body)
			response = construct_response(campus_drives)
			return response
		end


	# private

		def construct_response(drives_hash)
			college_ids = []
			result = []
			drives_hash["hits"]["hits"].each do |row|
				college_ids << row["_parent"].to_i
			end
			college_ids.uniq!
			body = @query_constructor.filter_by_ids(college_ids)
			colleges_hash = @query_executor.execute_college(body)
			drives_hash["hits"]["hits"].each do |row|
				result << {:drive_id=>row["_id"].to_s,:college=>get_company_from_hash(colleges_hash,row["_parent"]),:campus_drive=>row["_source"] }
			end
			return result
		end

		def get_company_from_hash(hash,company_id)
			company_hash = {}
			hash["hits"]["hits"].each do |row|
				company_hash = row["_source"]  if row["_id"].to_s == company_id.to_s
			end
			return company_hash
		end

	end
end
