class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = '你不是管理員'
      redirect_to root_path
    end
  end

  def index
    @suggests = Job.published.random5
  end  
end
