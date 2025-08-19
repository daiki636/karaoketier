class TweetsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

def index
  if params[:search].blank?
    @tweets = Tweet.all
    @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  else
    @tweets = Tweet.where("song LIKE ? OR artist LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end
  @rank_tweets = Tweet.order(overall: :desc).limit(5)
  @rank_tweets_by_like = Tweet.all.sort_by { |t| -t.liked_users.count }.first(5)
  @rank_tweets_by_score = Tweet.order(overall: :desc).limit(5)

  if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|      
        @tweets += Tag.find_by(name: key).tweets if value == "1"
      end
      @tweets.uniq!
    end

  if params[:tag]
      Tag.create(name: params[:tag])
    end

end


#追加箇所
  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
     tweet.user_id = current_user.id  #追記

    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

 def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

def show
  @tweet = Tweet.find(params[:id])
end

def tier
    base = Tweet
          .left_joins(:likes)
          .group('tweets.id')
          .order(Arel.sql('COUNT(likes.id) DESC'))
  # ※ユーザー単位で数えるなら ↑ を COUNT(DISTINCT likes.user_id) に
  @s_tier     = base.limit(3)           # 1〜3位（3件）
  @Aplus_tier = base.offset(3).limit(6) # 4〜9位（6件）
  @A_tier     = base.offset(9).limit(9) # 10〜18位（9件）
  top18_ids = base.limit(18).pluck(:id)
  rand_sql  = ActiveRecord::Base.connection.adapter_name =~ /mysql/i ? 'RAND()' : 'RANDOM()'
  @pickup_tier = Tweet.where(id: top18_ids).order(Arel.sql(rand_sql)).limit(15)
end

  private
  def tweet_params
    params.require(:tweet).permit(:song, :artist, :overall, :level, :comment, :image, :difficulty, :fame, tag_ids: [])
  end
 #ここまで

end









