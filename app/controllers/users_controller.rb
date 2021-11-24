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
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :username, :social_id)
  end
end
