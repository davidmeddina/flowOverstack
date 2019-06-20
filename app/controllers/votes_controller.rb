class VotesController < ApplicationController

  def create
    @parent = parent
    @vote = @parent.votes.create(user: current_user)

    redirect_to question_path(@parent.question_id) if @vote.votable_type == 'Answer'
    redirect_to question_path(@parent) if @vote.votable_type == 'Question'
  end
  
  def destroy
    @parent = parent
    @vote = @parent.votes.where(user: current_user).take.try(:destroy)

    redirect_to question_path(@parent.question_id) if @vote.votable_type == 'Answer'
    redirect_to question_path(@parent) if @vote.votable_type == 'Question'
  end
  
  private

  def parent
    if params[:question_id]
      Question.find(params[:question_id])
    else
      Answer.find(params[:answer_id])
    end
  end

end
