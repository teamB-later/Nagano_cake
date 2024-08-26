Rails.application.routes.draw do
  namespace :public do
    get 'searches/index'
  end
  namespace :admin do
    get 'searches/index'
  end
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    # public/search/index
    get 'search', to: 'searches#index'
    # public/items
    resources :items, only: [:index, :show]
    resource :customers, path: 'customers/my_page', only: [:show]
    resource :customers, path: 'customers/information', only: [:edit, :update]
    get 'customers/unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw', as: 'withdraw'
    # public/cart_items
    delete 'cart_items/destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    # public/orders
    get 'orders/thanks', as: 'thanks'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm', as: 'confirm'
    # public/addresses
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    # admin/homes
    get '' => 'homes#top'
    # admin/search/index
    get 'search', to: 'searches#index'
    # admin/items
    resources :items, except: [:destroy]
    # admin/genres
    resources :genres, only: [:index, :create, :edit, :update]
    # admin/customers
    resources :customers, only: [:index, :show, :edit, :update]
    # admin/orders
    resources :orders, only: [:show, :update]
    # admin/order_details
    resources :order_details, only: [:update]
  end

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end