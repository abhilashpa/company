class QueryConstructor
		SIZE = 4

		def initialize(keyword=nil,from=0,sort_by=nil,loc_filter=nil,dept_filter=nil,openings_search_fields=nil,companies_search_fields=nil)
			@body = {from: from, size: SIZE, query: { bool: {should: []} } }
			@openings_search_fields = ["address", "department", "location.name"]
			@college_search_fields = ["city", "college_name", "university_name"]
			@sort_by = sort_by if sort_by.present?
			@locations = loc_filter if loc_filter.present?
			@dept =  dept_filter if dept_filter.present?
			@companies_search_fields = companies_search_fields if companies_search_fields.present?
			@openings_search_fields = openings_search_fields if openings_search_fields.present?
			@keyword = keyword if keyword.present?
			add_minimum_should if keyword.present?
		end

		def create
			if @keyword.present?
				searach_by_openings
				searach_by_parent_company
			end
			sort_by if @sort_by.present?
			location_filter(@locations) if @locations.present?
			department_filter(@dept) if @dept.present?
			return @body
		end

		def location_filter(filters)
			@body[:query][:bool][:filter] = { :bool=> { :must=> [] } } if !@body[:query][:bool][:filter].present?
			@body[:query][:bool][:filter][:bool][:must] << { :terms=> { :"location.name"=> filters } }
			@body[:query][:bool][:minimum_should_match] = 1 if @body[:query][:bool][:should].present?  # if it is queried and filter then add this condition
			return @body
		end

		def department_filter(filters)
			@body[:query][:bool][:filter] = { :bool=> { :must=> [] } } if !@body[:query][:bool][:filter].present?
			@body[:query][:bool][:filter][:bool][:must] << { :terms=> {:department=> filters }}
			@body[:query][:bool][:minimum_should_match] = 1 if @body[:query][:bool][:should].present?  # if it is queried and filter then add this condition
			return @body
		end

		def top_city_list
			body = {
				:_source=>["location.name"],
				:query =>{
					:match_all=>{}
				}
			}
		end

		def select_top_departments
			body = {
				:_source=>["department"],
				:query =>{
					:match_all=>{}
				}
			}
		end

		def filter_by_ids(ids)
			body = {
				:query=> {
				    :constant_score=> {
				      :filter=>{
				        :terms=> {
				          :_id=> ids
				        }
				      }
				    }
				}
			}
			return body
		end
end