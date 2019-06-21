# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_type :string
#  votable_id   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user
end
