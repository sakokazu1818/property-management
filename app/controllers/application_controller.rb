class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def restrict_access
    return if session[:admin_id] && Administrator.find(session[:admin_id])

    flash[:request_url] = request.url if params[:request_url].blank?
    flash[:alert] = '登録またはログインが必要です'
    session[:admin_id] = nil

    redirect_to root_path
  end
end
