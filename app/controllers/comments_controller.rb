class CommentsController < ApplicationController
  def index
    @comment = Comment.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item)
    else
      redirect_to item_path(@item)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end