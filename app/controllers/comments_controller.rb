# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @parent = parent
    @comment = @parent.comments.new comment_params

    respond_to do |format|
      if @comment.save
        format.html { redirect_to question_path(@parent.question_id) } if @comment.commentable_type == 'Answer'
        format.html { redirect_to question_path(@parent) } if @comment.commentable_type == 'Question'
        format.js
      else
        format.html { 'questions/show' }
        flash[:error] = 'El comentario no se ha agregado correctamente'
      end
    end
    # if @comment.commentable_type == "Answer"
    #   redirect_to question_path(@parent.question_id)
    # else
    #   redirect_to question_path(@parent)
    # end
  end

  private

  def parent
    if params[:question_id]
      Question.find(params[:question_id])
    else
      Answer.find(params[:answer_id])
      # return Question.find(params[:question_id]).find(params[:answer_id])
    end
    # return Question.find(params[:question_id]) if params[:question_id]
    #       Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
