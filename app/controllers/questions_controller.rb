# frozen_string_literal: true

class QuestionsController < ApplicationController
  # before_action :authentica_user!, except: %i[index show]
  before_action :set_param, only: %i[show edit update destroy]
  before_action :private_access, except: %i[index show]

  def index
    @questions = Question.search(params[:search]).order(created_at: :desc)
  end

  def show
    @answer = Answer.new
    # @comment = @question.comments.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(questions_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        flash[:success] = 'Pregunta creada correctamente'
        format.html { redirect_to questions_path }
      else
        format.html { render :new }
        format.js { render :error }
      end
    end
  end

  def edit; end

  def update

    respond_to do |format|
      if @question.update(questions_params)
        flash[:success] = 'Pregunta actualizada correctamente'
        format.html { redirect_to question_path(@question) }
      else
        format.html { render :new }
        format.js { render :error }
      end
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
    flash[:success] = 'Pregunta eliminada correctamente'
  end

  private

  def set_param
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :content, :rating, :user_id)
  end

  def private_access
    redirect_to new_user_session_path unless user_signed_in?
  end
end
