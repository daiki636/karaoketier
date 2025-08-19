Rails.application.routes.draw do
  devise_for :users

  # ルートページ
  root 'tweets#index'

  resources :tweets do
    resources :likes, only: [:create, :destroy]

    collection do
      get :tier   # ← ここでランキングページを追加
    end
  end

  # ヘルスチェック（必要であれば）
  get "up" => "rails/health#show", as: :rails_health_check
end
