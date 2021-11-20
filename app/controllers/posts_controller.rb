class PostsController < ApplicationController
  def index
    @posts = Post.all

    puts @posts.inspect

    render :json => @posts.to_json 
  end

  def create
    @post = Post.new(post_params)

    @post.save

    if @post 
      payload = {
        success: 'much'
      }

      render :json => payload, :status => 200
    else 
      render :json => {error: "you baaaad"}, :status => 400
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
