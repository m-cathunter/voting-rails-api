class Vote < ApplicationRecord
  belongs_to :voting, required: :true
  validates :name, :number, presence: true
  validates :number, numericality: true
end
