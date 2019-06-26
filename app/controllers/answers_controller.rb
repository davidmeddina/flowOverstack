# frozen_string_literal: true

class AnswersController < ApplicationController
  
  def show
    @question = Question.find(params[:question_id])
    @answer = @question.find(params[:id])
    @comment = @answer.comments.new
  end

  #def index
   # @answers = Answer.all.order(created_at: :desc)
  #end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(ans_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@question) }
        format.js { flash.now[:success] = 'La respuesta se ha agregado correctamente' }
      else
        format.js
        format.html { 'questions/show' }
      end
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.js { flash.now[:success] = 'Respuesta eliminada correctamente' }
    end
  end

  private

  def ans_params
    params.require(:answer).permit(:content, :rating).merge(user: current_user)
  end
end
