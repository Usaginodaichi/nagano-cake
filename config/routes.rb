Rails.application.routes.draw do

  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
# URL/customers/sign_in...
  devise_for :customers, skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions:"public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 管理者用
# URL/admin/sign_in...
  devise_for :admin, skip:[:registrations, :passwords], controllers:{
    sessions:"admin/sessions"
  }

  get 'top' =>'public/homes#top'
  root to:"public/homes#top"
  get '/about' =>'public/homes#about'

  namespace :admin do
   root to:"homes#top"
   resources:genres, only:[:index, :create, :edit, :update]
   resources:items, only:[:new, :index, :create, :show, :edit, :update]
   resources:customers, only:[:index, :show, :edit, :update]
   resources:orders, only:[:show, :update]
  end

  namespace :public do
    get '/customers/my_page' =>'customers#show'
    get '/customers/information/edit' =>'customers#edit'
    patch '/customers/information' =>'customers#update'
    get 'customers/unsubscribe' =>'customers#unsubscribe'
    patch '/customers/withdraw' =>'customers#unsubscribe'
  end
end
