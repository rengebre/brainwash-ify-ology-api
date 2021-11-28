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

    
    @post = Post.new(post_params)
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&", cl_image_path(@post.thumbnail.key)

    @tag = cl_image_tag("#{@post.thumbnail.key}", :transformation=>[
      {:width=>350, :crop=>"scale"},
      {:fetch_format=>:auto}
      ])
    
    puts "######################", @tag

    
    if @post.save!
      payload = {
        file: Cloudinary::Utils.cloudinary_url(@post.upload_file.key),
        content: @post.content_type_upload_file, 
        thumbnail_file: Cloudinary::Utils.cloudinary_url(@post.thumbnail.key),
        thumbnail_content: @post.content_type_thumbnail
      }
      render :json => payload, :status => 200
    else 
      render :json => {error: "you baaaad"}, :status => 400
    end
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

    if @post.upload_file.attached? 
      @file["upload_file"] = Cloudinary::Utils.cloudinary_url(@post.upload_file.key)
      @file["content"] = @post.content_type_upload_file
    end
    
    @returnObj = {comments: @comments, post: @post, likes: @likes, postUserInfo: @postUserInfo, commentInfo: @commentInfo, file: @file}
    render :json => @returnObj


  end



  def destroy 
    @post = Post.find(params[:id])
    @post.destroy

    render :json => {message: "post successfully dEsTroYed"}, :status => 202
  end

  private
  def post_params
    params.permit(:title, :description, :post_type, :interest_id, :upload_file, :thumbnail, :user_id)
  end
end