class DashboardController < AuthenticatedController
  layout 'landing'
  before_filter :check_company_registration
  def index
    
  end
  
  private
  def check_company_registration
    if current_user.company_detail_users.blank?
      redirect_to "/college_registration"
    end
  end
end
