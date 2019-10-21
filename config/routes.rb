# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'login#index'

  scope :login, controller: 'login' do
    get '/', action: :index
    get 'index'
    post 'login'
    post 'logout'
  end

  resources :properties do

    collection do
      post 'download'
    end
  end
end
