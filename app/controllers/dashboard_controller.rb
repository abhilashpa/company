class DashboardController < AuthenticatedController
  layout 'dashboard'
  before_filter :check_company_registration
  def index

  end

  def create_opening
  end

  def save_opening
  end

  def cities
    city_obj = List::City.new
    cities = city_obj.search
    response = {:data=>cities}
    render :json=>response.to_json
  end

  def departments
      dept_obj = List::Department.new
      department_list = dept_obj.search
      response = {:data=>department_list}
      render :json=>response.to_json
  end

  def search_college_drives
    response = {}
    sort_option = params["sort_option"]
    location_filter = params["l"].collect(&:downcase) if params["l"].present?
    department_filter = params["d"].collect{|item|  item.downcase.split(" ") }.flatten if params["d"].present?
    query = params["q"]
    from = params["f"] || 0
    data = []
    sb = Search::SearchBase.new(query,from,sort_option,location_filter,department_filter)
    data = sb.search
    render :json=>{"campus_drives"=>data,"message"=>"","error"=>""}
  end

  private
  def check_company_registration
    if current_user.company_detail_users.blank?
      redirect_to "/company_registration"
    end
  end
end
