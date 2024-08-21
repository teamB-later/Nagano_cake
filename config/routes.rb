Rails.application.routes.draw do
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
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
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm', as: 'confirm'
    get 'orders/thanks', as: 'thanks'
    # public/addresses
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    # admin/homes
    get '' => 'homes#top'
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
