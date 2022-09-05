Rails.application.routes.draw do

# 顧客用
# URL/customers/sign_in...
  devise_for:customers, skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions:"public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 管理者用
# URL/admin/sign_in...
  devise_for:admin, skip:[:registrations, :passwords], controllers:{
    sessions:"admin/sessions"
  }

  get 'top' =>'public/homes#top'
  root to:"public/homes#top"
  get '/about' =>'public/homes#about'

  namespace :admin do
   root to:"homes#top"
  end



end
