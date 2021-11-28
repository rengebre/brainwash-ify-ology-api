class UsersController < ApplicationController
  def index
  end

  def create
    # puts "social_id: #{user_params[:social_id]}"
    @user = User.find_by social_id: user_params[:social_id]

    if !@user
      @user = User.create!(user_params)
    end

    render :json => @user
  end

  def show
    @user = User.find(params[:id])
    @how_many_user_is_following = @user.followed_follows.count
    @how_many_followers_user_has = @user.follower_follows.count
    
    @following = Follow.where(["follower_id = ? AND followed_id = ?", params["dbUserId"].to_i, params[:id].to_i])
    @isFollowing = false
    @follow_id = nil
    
    if !@following.empty? 
      @isFollowing = true
      @follow_id = @following[0][:id]
    end
    
    puts "$$$$$$$$ #{@following.inspect} $$$$$$$$$$$$"

    @returnObj = {user: @user, how_many_user_is_following: @how_many_user_is_following, how_many_followers_user_has: @how_many_followers_user_has, isFollowing: @isFollowing, follow_id: @follow_id}
    render :json => @returnObj
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :social_img, :avatar, :username, :social_id)
  end
end
