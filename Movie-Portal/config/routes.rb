Rails.application.routes.draw do
  get 'welcome/index'
  get 'login'=>'login#index'
  post 'create' => 'login#create'
  post 'login' => 'login#login'	
  get 'admin' => 'login#admin'
  get 'users' => 'login#users'	
root 'welcome#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
