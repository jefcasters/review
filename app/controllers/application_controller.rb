class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if admin?
      users_path
    else
      super
    end
  end


  def admin?
    current_user.admin
  end

  rescue_from CanCan::AccessDenied do |exception|
   redirect_to user_documents_path(current_user.id), :alert => "you were not authorized to acces this page and have been redirected"
  end

end
