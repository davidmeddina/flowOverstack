# frozen_string_literal: true

class CommentsController < ApplicationController
  
  def create
    @parent = parent
    @comment = @parent.comments.new comment_params
    @comment.save
    redirect_to question_path(@question)
  end

  private

  def parent
    return Question.find(params[:question_id]) if params[:question_id]
    Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
