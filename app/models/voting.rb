# frozen_string_literal: true

class Voting < ApplicationRecord
  has_many :votes
  validates :name, :number_of_votes, presence: true
end
