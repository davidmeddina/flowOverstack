class QuestionsController < ApplicationController
  before_action :set_param, only: [:show]

  def index
  @questions = Question.all.order(id: :desc)
  end

  def show
  end

  def new
  @question = Question.new
  end

  def create
  @question = Question.new(questions_params)
  @question.user = current_user
    if @question.save
      redirect_to questions_path
    else
      render :new
    end

  end

  private
  def set_param
  @question = Question.find(params[:id])
  end

  def questions_params
  params.require(:question).permit(:title, :content, :rating, :user_id)  
  end

end
