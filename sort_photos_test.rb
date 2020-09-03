require 'test/unit'
require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @sort_photos = SortPhotos.new
  end

  def test_get_year
    assert_equal '2020', @sort_photos.get_year('example_photos/IMG_6036.jpg'), "Years don't match"
  end

  def test_get_month
    assert_equal '08', @sort_photos.get_month('example_photos/IMG_6036.jpg'), "Months don't match"
  end

  def test_get_day
    assert_equal '27', @sort_photos.get_day('example_photos/IMG_6036.jpg'), "Days don't match"
  end

end
