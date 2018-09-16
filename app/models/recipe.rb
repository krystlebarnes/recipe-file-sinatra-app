class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
end
