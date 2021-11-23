class CommentsController < ApplicationController

  def create
  
    comment_parameters = {
      :content => comment_params["content"],
      :user_id => comment_params["user_id"],
      :post_id => comment_params["post_id"]
    }
    
    @comment = Comment.new(comment_parameters)
    @comment.save!

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  

  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
  
end
