class PostsController < ApplicationController
  def index
    @posts = Post.all

    render :json => @posts
  end

  def create
    @post = Post.new(post_params)

    save_flag = @post.save

    if save_flag
      payload = "{
        success: 'much'
      }"

      render :json => payload, :status => 200
    else 
      render :json => {error: "you baaaad"}, :status => 400
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    @post.destroy

    render :json => {message: "post successfully dEsTroYed"}, :status => 202
  end

  private
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
