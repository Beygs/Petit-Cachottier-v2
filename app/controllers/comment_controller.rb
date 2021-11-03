class CommentController < ApplicationController
  def create
    @comment = Comment.new(
      commentable: Gossip.find(params[:commentable]),
      user: User.find_by(first_name: 'anonymous'),
      content: params[:content]
    )
    @comment.save
    redirect_to Gossip.find(params[:commentable])
  end
end
