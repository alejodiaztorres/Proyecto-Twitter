class TweetsController < ApplicationController

  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /tweets
  # GET /tweets.json 
  def index
    # @tweets = Tweet.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
    _tweets = params[:q] ? Tweet.where("tweet like ?", "%#{ params[:q] }%") : Tweet.order(created_at: :desc)
    @tweets = _tweets.paginate(page: params[:page], per_page: 50)
    @tweet = Tweet.new

    # if params[:tweet].present?
    #   Tweet.where('tweet = ?', params[:tweet])
    # end
  end


  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @retweet = @tweet.tweets.build
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params) 

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    tweet = current_user.tweets.new(tweet_id: @tweet.id, tweet: @tweet.tweet)
    if tweet.save
      redirect_to tweets_path
    else
      redirect_to :back, alert: "Unable to retweet"
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet, :tweet_id)
    end
end
