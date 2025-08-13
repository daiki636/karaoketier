Rails.application.routes.draw do
  devise_for :users
# ルートページ
 

  # tweetsのルーティングをまとめて定義
 get 'tier/html' => 'tier#html'
  resources :tweets do
  resources :likes, only: [:create, :destroy]

  # ヘルスチェック（必要であれば）
  get "up" => "rails/health#show", as: :rails_health_check
  end



   root 'tweets#index'
end