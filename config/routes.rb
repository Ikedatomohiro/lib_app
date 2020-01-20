Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root 'users#index'

resources :users

get  'notice'                         => 'users#notice'
get  'shelf'                          => 'users#shelf'
get  'setting'                        => 'users#setting'
get  'impression'                     => 'users#impression'
get  'bookinfo'                       => 'users#bookInfo'
get  'readinghistory'                 => 'users#readingHistory'
post 'users/update_self_introduction' => 'users#update_self_introduction' 
get  'request'                        => 'users#request_page'
post 'user/publish_impression'        => 'users#update_publish_impression'


resources :books
post 'book/search'        => 'books#search_books'
get  'book/show_form'     => 'books#show_search_form'
end
