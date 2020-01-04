Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


root 'users#index'

get  'user'               => 'users#show'
get  'notice'             => 'users#notice'
get  'shelf'              => 'users#shelf'
get  'setting'            => 'users#setting'
get  'edit'               => 'users#edit'
get  'update'             => 'users#update'
get  'bookinfo'           => 'users#bookInfo'
get  'readinghistory'     => 'users#readingHistory'

end
