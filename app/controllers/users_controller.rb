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
      user_return["avatar"] = url_for(@user.avatar)
    end

    render :json => user_return, :status => 200
  end

  def show
    @user = User.find(params[:id])
    
    user_return = {
      user: @user,
      avatar: ""
    }

    if @user.avatar.attached?
      user_return["avatar"] = url_for(@user.avatar)
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

    user_return = {
      user: @user,
      avatar: ""
    }

    if @user.avatar.attached?
      user_return["avatar"] = url_for(@user.avatar)
    end


    @user.update(update_params)
    
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
