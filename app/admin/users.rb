ActiveAdmin.register User do

  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :nickname, :picture, :active, :tweets, :likes, :tweet_id
  
  index do
    selectable_column
    id_column
    column :email
    column :active, if: proc { |user| user.active }
    column :tweets do |tweet|
      tweet.tweets.count
    end
    column :retweets do |rt|
      rt.tweets.count
    end
    column :likes do |like|
      like.tweets.count
    end
    actions
  end
  

end
