Rails.application.routes.draw do

  root "sys_infos#index"

  resources :sys_infos do
    member do 
      post :upload_import
    end
  end
end
