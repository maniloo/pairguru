class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)

    if comment.save
      redirect_to request.referer, notice: "Comment added successfully"
    else
      redirect_to request.referer, flash: { error: "Comment can't be added" }
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer, notice: "Comment destroyed successfully"
  end

  private

  def comment_params
    {
      movie_id: params[:comment][:movie_id],
      user_id: current_user.id,
      content: params[:comment][:content]
    }
  end
end
