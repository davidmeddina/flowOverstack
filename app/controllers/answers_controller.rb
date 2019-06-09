# frozen_string_literal: true

class AnswersController < ApplicationController
  def index
    @answers = Answer.all.order(created_at: :desc)
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(ans_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@question) }
        flash[:success] = 'Comentario agregado correctamente'
      else
        format.html { 'questions/show' }
        flash[:alert] = 'El comentario no se ha agregado correctamente'
      end
      # format.js
    end
  end

  private

  def ans_params
    params.require(:answer).permit(:content, :rating).merge(user: current_user)
  end
end
