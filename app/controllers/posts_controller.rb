class PostsController < ApplicationController
  def index

    filter = JSON.parse(params[:filter])

    queryString = ""
    queryArray = []

    if filter["user_id"]
      queryString += "user_id = ?"
      queryArray.push filter["user_id"]
    end
    
    if !filter["interests"].empty?
      if !queryString.empty?
        queryString += " AND "
      end
      queryString += "interest_id IN (?)"
      @interestId = filter["interests"].map {|obj| obj["value"]}
      queryArray.push @interestId
    end

    queryArray.unshift queryString
    
    if queryArray.length > 1
      @posts = Post.where(queryArray).order(updated_at: :desc)
    else 
      @posts = Post.all.order(updated_at: :desc)
    end

    @postCounts = @posts.map { |post| 
      {"#{post[:id]}": [post.likes.count, post.comments.count]}
    }

    @users = @posts.map { |post| post.user}

    @returnObj = { posts: @posts, users: @users, postCounts: @postCounts }

    render :json => @returnObj
  end

  def create

    # interest_id = Interest.where(name: post_params["interest_name"])[0].id
   
    # post_parameters = {
    #   :user_id => post_params["user_id"], 
    #   :title => post_params["title"], 
    #   :description => post_params["description"], 
    #   :upload_file => post_params["upload_file"],
    #   :interest_id => interest_id, 
    #   :post_type => post_params["post_type"]
    # }

    # @post = Post.new(post_parameters)

    # save_flag = true
    # @post.save!

    puts "params ****** #{params}"

    # if save_flag
    #   payload = "{
    #     success: 'much'
    #   }"
    render :json => { hello: "heyyyy" }
    #   render :json => payload, :status => 200
    # else 
    #   render :json => {error: "you baaaad"}, :status => 400
    # end
  end


  def show
    #retrieve all comments for individual post
    @post = Post.find(params[:id])
    @comments = @post.comments.order(updated_at: :desc)

    @commentUserInfo = @comments.map { |comment| 
      userInfo = User.where('id = ?', comment.user_id)
      {comment: comment, user: userInfo}
    }
    puts "******", @commentUserInfo
    # @commentsUserId = User.where("id = ?", @comment[user_id])

    #sends us like count for given post
    @likes = @post.likes
    @userName = @post.user.username
    
    @returnObj = {comments: @comments, post: @post, likes: @likes, userName: @userName, commentUserInfo: @commentUserInfo}
    render :json => @returnObj
  end



  def destroy 
    @post = Post.find(params[:id])
    @post.destroy

    render :json => {message: "post successfully dEsTroYed"}, :status => 202
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :post_type, :interest_name, :upload_file, :user_id)
  end
end
