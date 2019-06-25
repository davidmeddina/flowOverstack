# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  content     :text
#  rating      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :content, presence: true

  def voted_by?(user)
    votes.exists?(user: user)
  end
end
