# frozen_string_literal: true

class LoginController < ApplicationController
  before_action :set_admin, only: :login

  def index; end

  def login
    if @admin&.authenticate(params[:password])
      session[:admin_id] = @admin.id
      flash[:notice] = 'ログインしました'

      redirect_to params[:request_url].present? ? params[:request_url] : delays_path
    else
      flash[:alert] = 'ログインに失敗しました'
      redirect_to root_path
    end
  end

  def logout
    session[:admin_id] = nil
    flash[:notice] = 'ログアウトしました'

    redirect_to root_path
  end

  private

  def set_admin
    @admin = Administrator.find_by(name: params[:login_name])
  end
end
