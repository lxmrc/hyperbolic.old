class Exercise < ApplicationRecord
  has_one_attached :test_file

  def tests
    test_file.blob.download
  end
end
