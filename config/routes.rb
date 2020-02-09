Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root 'users#index'

resources :users
get  'notice'                           => 'users#notice'
post 'notice'                           => 'users#notice'
get  'shelf'                            => 'users#shelf'
get  'setting'                          => 'users#setting'
get  'user/update_setting'              => 'users#update_setting'
post 'users/update_self_introduction'   => 'users#update_self_introduction' 
post 'user/publish_impression'          => 'users#update_publish_impression'
get  'bookinfo'                         => 'users#book_info'
get  'readinghistory'                   => 'users#reading_history'
get  'request'                          => 'users#request_page'
post 'user/add_book'                    => 'users#add_book'

resources :books
post 'book/search'                      => 'books#search_books'
get  'book/search'                      => 'books#search_books'
get  'books/search_books_result'        => 'books#search_books_result'
get  'book/show_form'                   => 'books#show_search_form'
get  'books/info/:isbn'                 => 'books#show_book_info'

resources :impressions
post 'impression/add_impression_field'  => 'impressions#add_impression_field'
get  'impression/:impression_link'      => 'impressions#impression'
post 'impression/show_reading_date'     => 'impressions#show_reading_date'
post 'impression/set_reading_date'      => 'impressions#set_reading_date'
end
