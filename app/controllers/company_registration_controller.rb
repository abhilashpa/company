class CompanyRegistrationController < AuthenticatedController
  layout 'landing'
  def index
  end

  def save
    params[:user_id] = current_user.id
    CRUD::Company::CreateUpdate.new.register params
    redirect_to '/dashboard'
  end
end
