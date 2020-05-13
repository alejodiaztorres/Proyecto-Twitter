ActiveAdmin.register User do

  permit_params :email, :active, :likes

  index do

    id_column
    column :email

    column "Cantidad likes",
      User.all.each do |user|
        user.likes.count
    end

    column "Cantidad tweets",
      User.all.each do |user|
        user.tweets.count
    end

    column "Cantidad retweets",
      User.all.each do |user|
        Tweet.where(user_id: user).count - Tweet.where(user_id: user).where(tweet_id: nil).count
    end

    column "Inactive",
      User.all.each do |user|
        user.active
    end
    actions
  end

end
