class PostsController < ApplicationController
  def index
    @posts = Post.all
    render :json => @posts
  end

  def create
    puts "HEYYYYYY #{post_params}"

    interest_id = Interest.where(name: post_params["interest_name"])[0].id
   
    # puts interest_id
    post_parameters = {
      :user_id => 1, 
      :title => post_params["title"], 
      :description => post_params["description"], 
      :upload_file => post_params["upload_file"],
      :interest_id => interest_id, 
      :post_type => post_params["post_type"]
    }

    @post = Post.new(post_parameters)

    
    save_flag = true
    @post.save!
    
    puts @post.inspect

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
    params.require(:post).permit(:title, :description, :post_type, :interest_name, :upload_file)
  end
end
