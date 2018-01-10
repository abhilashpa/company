class DashboardController < AuthenticatedController
  layout 'landing'
  before_filter :check_company_registration
  def index

  end

  def create_opening
  end

  def save_opening
  end

  private
  def check_company_registration
    if current_user.company_detail_users.blank?
      redirect_to "/company_registration"
    end
  end
end
