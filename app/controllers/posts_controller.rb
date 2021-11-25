class PostsController < ApplicationController
  def index
    if params[:filter]
      @interestId = params[:filter].map {|obj| JSON.parse(obj)["value"]}
      
      @posts = Post.where('interest_id IN (?)', @interestId)
    else 
      @posts = Post.all.order(updated_at: :desc)
    end
    
    @users = @posts.map { |post| post.user}  
    @returnObj = { posts: @posts, users: @users }

    render :json => @returnObj
  end

  def create

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

    if save_flag
      payload = "{
        success: 'much'
      }"

      render :json => payload, :status => 200
    else 
      render :json => {error: "you baaaad"}, :status => 400
    end
  end


  def show
    #retrieve all comments for individual post
    @post = Post.find(params[:id])
    @comments = @post.comments.order(updated_at: :desc)

    #sends us like count for given post
    @likes = @post.likes

    @userName = @post.user.username
    
    @returnObj = {comments: @comments, post: @post, likes: @likes, userName: @userName}
    render :json => @returnObj
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
