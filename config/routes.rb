Rails.application.routes.draw do

  root "sys_infos#index"

  resources :sys_infos do
    member do 
      post :upload_import
    end
  end

  namespace :api do
    resources :sys_infos, only: %i[show create update destroy]
  end
end
