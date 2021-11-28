class UsersController < ApplicationController
  def index
  end

  def create
    @user = User.find_by social_id: user_params[:social_id]

    if !@user
      @user = User.create!(user_params)
    end

    user_return = {
      user: @user,
      avatar: ""
    }

    if @user.avatar.attached?
      user_return["avatar"] = Cloudinary::Utils.cloudinary_url(@user.avatar.key)
    end

    render :json => user_return, :status => 200
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
    
    user_return = {
      user: @user,
      avatar: "",
      how_many_user_is_following: @how_many_user_is_following,
      how_many_followers_user_has: @how_many_followers_user_has,
      isFollowing: @isFollowing,
      follow_id: @follow_id
    }

    if @user.avatar.attached?
      user_return["avatar"] = Cloudinary::Utils.cloudinary_url(@user.avatar.key)
    end

    render :json => user_return, :status => 200
  end

  def update
    update_params = user_update_params
    
    @user = User.find(update_params[:id])
  
    if !@user
      render :json => {message: "no user found in db, how'd ya do it eh?"}, :status => 404
    end

    if update_params["avatar"]
      avatar = update_params["avatar"]

      @user.avatar.purge
      @user.avatar.attach(avatar)

      update_params.delete("avatar")
    end

    @user.update(update_params)

    user_return = {
      user: @user,
      avatar: ""
    }

    if @user.avatar.attached?
      user_return["avatar"] = Cloudinary::Utils.cloudinary_url(@user.avatar.key)
    end

    render :json => user_return, :status => 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :social_img, :avatar, :username, :social_id)
  end

  def user_update_params
    params.permit(:id, :email, :name, :username, :bio, :avatar)
  end
end
