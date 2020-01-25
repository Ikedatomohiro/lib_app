Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root 'users#index'

resources :users
get  'notice'                         => 'users#notice'
get  'shelf'                          => 'users#shelf'
get  'setting'                        => 'users#setting'
get  'user/update_setting'            => 'users#update_setting'
post 'users/update_self_introduction' => 'users#update_self_introduction' 
post 'user/publish_impression'        => 'users#update_publish_impression'
get  'user/impression/:isbn'          => 'users#impression'
get  'bookinfo'                       => 'users#book_info'
get  'readinghistory'                 => 'users#reading_history'
get  'request'                        => 'users#request_page'
get  'user/add_book/:isbn'            => 'users#add_book'

resources :books
post 'book/search'                    => 'books#search_books'
get  'book/show_form'                 => 'books#show_search_form'
get  'books/info/:isbn'               => 'books#show_book_info'
end
