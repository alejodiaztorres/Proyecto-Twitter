class Api::TweetsController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with name: "hello", password: "world"

    
    def index
        
        tweets = Tweet.all.order(created_at: :desc)
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
     
    def show
    end
     
    def create
        @tweet = Tweet.new(tweet_params)
    
        if @tweet.save
            render json: @tweet, status: :created
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end

    def update
        if @tweet.update(tweet_params)
            render json: @tweet, status: :ok
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end
     
    def destroy
        @tweet.destroy
        head :no_content
    end
     
    private

    def set_new
        @tweet = Tweet.find(params[:id])
    end
    
    def tweet_params
        params.require(:tweet).permit(:id, :tweet, :tweet_id, :user_id, :created_at, :updated_at)
    end
end

