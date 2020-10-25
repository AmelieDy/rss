class Content < ApplicationRecord
  belongs_to :feed

  paginates_per 5
end
