class Iteration < ApplicationRecord
  belongs_to :exercise, counter_cache: true
  has_one_attached :file

  def code
    file.blob.download if file.attached?
  end
end
