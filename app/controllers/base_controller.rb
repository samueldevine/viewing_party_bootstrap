class BaseController < ApplicationController
  before_action :require_login

  def require_login
    if !current_user
      flash[:warning] = 'You must be logged in to access this page'
      redirect_to root_path
    end
  end
end
