class Feed < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  has_many :contents
end