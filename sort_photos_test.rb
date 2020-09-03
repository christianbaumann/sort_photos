require 'test/unit'
require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @sort_photos = SortPhotos.new
  end

  def test_get_date
    assert_equal '2020-08-27', @sort_photos.get_date('example_photos/IMG_6036.jpg'), "Dates don't match"
  end

end
