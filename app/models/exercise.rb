class Exercise < ApplicationRecord
  has_many :iterations
  has_one_attached :test_file

  def tests
    test_file.blob.download
  end

  def test_file_on_disk
    ActiveStorage::Blob.service.send(:path_for, test_file.key)
  end

  def test_file_name
    "#{name.parameterize(separator: '_')}_test.rb"
  end
end
