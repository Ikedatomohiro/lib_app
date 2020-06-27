Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root 'users#index'

get  'notice'                           => 'users#notice'
post 'notice'                           => 'users#notice'
get  'setting'                          => 'users#setting'
get  'users/update_setting'             => 'users#update_setting'
post 'users/update_self_introduction'   => 'users#update_self_introduction' 
post 'users/publish_impression'         => 'users#update_publish_impression'
get  'readinghistory'                   => 'users#reading_history'
get  'request'                          => 'users#request_page'
get  'users/terms_of_service'           => 'users#terms_of_service'
get  'users/privacy_policy'             => 'users#privacy_policy'
post 'users/send_request'               => 'users#send_request'
get  'users/release_note'               => 'users#release_note'
get  'job'                        => 'users#job'
resources :users

get  'books/search_books_result'        => 'books#search_books_result'
post 'books/search'                     => 'books#search_books'
get  'books/search'                     => 'books#search_books'
get  'books/info/:api_id'               => 'books#show_book_info'
post 'books/set_reading_date'           => 'books#set_reading_date'
patch 'books/show_reading_date'         => 'books#show_reading_date'
patch 'books/update_thumbnail/:book_id' => 'books#update_thumbnail'
post 'books/search_from_barcode'        => 'books#search_from_barcode'
resources :books do
    put :sort
end

post 'impressions/add_impression_field' => 'impressions#add_impression_field'
post 'impressions/post_to_twitter'      => 'impressions#post_to_twitter'
resources :impressions

get  'contacts/thanks'                  => 'contacts#thanks'
resources :contacts

get  'shelves'                          => 'shelves#index'
post 'shelves/add_shelf'                => 'shelves#add_shelf'
get  'change_shelf_type/:shelf_type'    => 'shelves#change_shelf_type'
post 'shelves/add_book'                 => 'shelves#add_book'
resources :shelves do
    put :sort
end

delete 'likes/:impression_id'           => 'likes#destroy'
resources :likes, only: [:create]
end
