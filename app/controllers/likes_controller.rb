class LikesController < ApplicationController
  
  def create

    like_parameters = {
      :user_id => like_params["user_id"],
      :post_id => like_params["post_id"]
    }

    @like = Like.new(like_parameters)
    @like.save!

    render :json => @like
  end

  def destroy
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
