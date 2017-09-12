Rails.application.routes.draw do
  get 'welcome/index'
  get 'login'=>'login#index'
  post 'create' => 'login#create'
  post 'login' => 'login#login'	
  post 'select'=> 'login#select'
  get 'users' => 'login#users'
  get 'admin' => 'login#admin'	
  get 'admin/addmov'=> 'addmov#_addmov'
root 'welcome#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
