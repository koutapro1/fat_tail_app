class Morph < ApplicationRecord
  validates :name,   presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true
end
