module List
	class Department < Search::SearchBase

		def initialize			
			@query_constructor = QueryConstructor.new
			@query_executor = QueryExecutor.new
		end

		def search
			body = @query_constructor.select_top_departments
			puts "#{body.inspect}"
			openings = @query_executor.execute_college_drive(body)
			response = construct_response(openings)
			return response
		end

		def construct_response(data)
			locations = []
			data["hits"]["hits"].each do |item|
				locations << {:name=> item["_source"]["department"]}
			end			
			locations.uniq! {|e| e[:name]}
			return locations
		end
	end
end