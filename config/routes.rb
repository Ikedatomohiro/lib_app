Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root 'users#index'

get  'notice'                           => 'users#notice'
post 'notice'                           => 'users#notice'
get  'shelf'                            => 'users#shelf'
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
resources :users

get  'books/search_books_result'        => 'books#search_books_result'
post 'books/search'                     => 'books#search_books'
get  'books/search'                     => 'books#search_books'
get  'books/show_form'                  => 'books#show_search_form'
get  'books/info/:api_id'               => 'books#show_book_info'
post 'books/set_reading_date'           => 'books#set_reading_date'
patch 'books/show_reading_date'         => 'books#show_reading_date'
patch 'books/update_thumbnail/:book_id'  => 'books#update_thumbnail'
resources :books do
    put :sort
end

post 'impressions/add_impression_field' => 'impressions#add_impression_field'
post 'impressions/post_to_twitter'      => 'impressions#post_to_twitter'
resources :impressions

get  'contacts/thanks'                  => 'contacts#thanks'
resources :contacts
end
