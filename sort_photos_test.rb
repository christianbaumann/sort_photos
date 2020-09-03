require 'test/unit'
require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @sort_photos = SortPhotos.new
  end

  def test_get_year
    assert_equal '2020', @sort_photos.get_year('example_photos/IMG_6036.jpg'), "Years don't match"
  end

end
