Rails.application.routes.draw do
  resources :subjects
  resources :students
  resources :teachers
  root 'home#page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
