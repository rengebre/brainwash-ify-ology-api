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
    render :json => @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :social_img, :avatar, :username, :social_id)
  end
end
