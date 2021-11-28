class FollowsController < ApplicationController
  def create
    @follow = Follow.new(follow_params)
    
    @follow.save!

    render :json => {success: "you did it"}, :status => 200
  end

  def destroy
    puts "******", params
    @follow = Follow.find(params[:id])
    @follow.destroy

    render :jsoon => {success: "she twas destroyed"}
  end

  private
  def follow_params
    params.require(:follows).permit(:follower_id, :followed_id)
  end
end
