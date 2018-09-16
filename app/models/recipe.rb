class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :serving_size, numericality: { only_integer: true }, allow_nil: true
  validates :prep_time, numericality: { only_integer: true }, allow_nil: true
  validates :cook_time, numericality: { only_integer: true }, allow_nil: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
end
