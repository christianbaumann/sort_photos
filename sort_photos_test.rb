require 'test/unit'
require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @sort_photos = SortPhotos.new
  end

  def test_get_date
    assert_equal '2020-08-27', @sort_photos.get_date('example_photos/IMG_6036.jpg'), "Dates don't match"
  end

  def test_create_directory
    date = @sort_photos.get_date('example_photos/IMG_6036.jpg')
    target_directory = @sort_photos.target_directory

    assert_equal "#{target_directory}/#{date}", @sort_photos.create_directory('example_photos/IMG_6036.jpg')[0], "Directory path is not correct"
    assert_equal true, File.directory?("#{target_directory}/#{date}"), "Directory doesn't exist"
  end

end
