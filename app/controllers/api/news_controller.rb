class Api::NewsController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with name: "hello", password: "world"
    

    def index

        tweets = Tweet.all.order(created_at: :desc).limit(50)
        @tweets = tweets.map {|tweet| { 
            id: tweet.id, 
            content: tweet.tweet, 
            user: tweet.user_id,  
            like_count: tweet.likes.count,
            retweets: tweet.tweet_id, 
            retwitter_from: tweet.user_id
            }}
        render json: @tweets
    end
     
    private
    
    def tweet_params
        params.require(:tweet).permit(:id, :tweet, :tweet_id, :user_id, :created_at, :updated_at)
    end
end
