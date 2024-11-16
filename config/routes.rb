Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions'
  }

  scope module: :public do
  #エンドユーザー側のルーティング

    root 'homes#top'

    get 'about', to: 'homes#about', as: 'about'

    resources :items, only: [:index, :show]

    resource :customers, only: [] do
      get 'mypage', to: 'customers#show'
      get 'information/edit', to: 'customers#edit'
      patch 'information', to: 'customers#update'
      get 'confirm_leave', to: 'customers#confirm_leave'
      patch 'leave', to: 'customers#leave'
    end 
    
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all', to: 'cart_items#destroy_all'
      end
    end


    resources :orders, only: [:new, :create, :index, :show] do
      post 'confirm_order', to: 'orders#confirm_order', as: 'confirm_order'
      get 'complete_order', to: 'orders#complete_order', as: 'complete_order'
    end

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
  }

  namespace :admin do
  #管理者側のルーティング
    root 'homes#top'

    resources :items, except: [:destroy]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update]

    resources :order_details, only: [:update]

  end

end
