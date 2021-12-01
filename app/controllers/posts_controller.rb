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
    
    @thumbnails = {}
    @posts.each { |post| 
      if post.thumbnail.attached?
        @thumbnails[post[:id]] = Cloudinary::Utils.cloudinary_url(post.thumbnail.key)
      end
    }
    
    @returnObj = { posts: @posts, users: @users, postCounts: @postCounts, thumbnails: @thumbnails }

    render :json => @returnObj
  end

  def create
    post_db_params = post_params
    thumbnail = false
    upload_file = false

    if post_db_params["thumbnail"]
      thumbnail = post_db_params["thumbnail"]
      post_db_params.delete("thumbnail")
    end

    if post_db_params["upload_file"]
      upload_file = post_db_params["upload_file"]
      post_db_params.delete("upload_file") 
    end


    @post = Post.new(post_db_params)
    
    @post.save!

    payload = {
      "post" => @post
    }

    if thumbnail
      @post.thumbnail.attach(thumbnail)
      payload["thumbnail_file"] = Cloudinary::Utils.cloudinary_url(@post.thumbnail.key)
      payload["thumbnail_content"] = @post.content_type_thumbnail
    end

    if upload_file
      @post.upload_file.attach(upload_file)
      payload["file"] = Cloudinary::Utils.cloudinary_url(@post.upload_file.key, :resource_type => "video")
      payload["content"] = @post.content_type_upload_file
    end
  
    render :json => payload, :status => 200
  end


  def show
    #retrieve all comments for individual post
    @post = Post.find(params[:id])
    @comments = @post.comments.order(updated_at: :desc)

    @commentInfo = @comments.map { |comment| 
      userInfo = User.find(comment.user_id)
      {comment: comment, user: userInfo}
    }
 
    @likes = @post.likes

    @postUserInfo = {
      username: @post.user.username,
      id: @post.user.id
    }

    @file = {
      upload_file: "",
      content: ""
    }

    options = {}

    if @post.upload_file.attached? 
      @file["upload_file"] = Cloudinary::Utils.cloudinary_url(@post.upload_file.key, :resource_type => "video")
      @file["content"] = @post.content_type_upload_file
    end
    
    @returnObj = {comments: @comments, post: @post, likes: @likes, postUserInfo: @postUserInfo, commentInfo: @commentInfo, file: @file}
    render :json => @returnObj


  end



  def destroy 
    @post = Post.find(params[:id])

    # Delete attachments if they exist
    @post.upload_file.purge
    @post.thumbnail.purge
    
    # Delete the entry in our db
    @post.destroy

    # {message: "post successfully dEsTroYed"}
    render :json => {message: "post successfully dEsTroYed"}, :status => 202
  end

  private
  def post_params
    params.permit(:title, :description, :post_type, :interest_id, :upload_file, :thumbnail, :user_id)
  end
end