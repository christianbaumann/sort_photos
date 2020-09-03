require 'test/unit'
require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @example_photo = 'example_photos/IMG_6036.jpg'

    @sort_photos = SortPhotos.new
  end

  def teardown
    FileUtils.rm_rf @sort_photos.target_directory
  end

  def test_get_date
    assert_equal '2020-08-27', @sort_photos.get_date(@example_photo), "Dates don't match"
  end

  def test_create_directory
    date = @sort_photos.get_date(@example_photo)
    target_directory = @sort_photos.target_directory

    assert_equal "#{target_directory}/#{date}", @sort_photos.create_directory(@example_photo), 'Directory path is not correct'
    assert_true File.directory?("#{target_directory}/#{date}"), "Directory doesn't exist"
  end

  def test_get_filename
    assert_equal 'IMG_6036.jpg', @sort_photos.get_filename(@example_photo), "Filenames don't match"
  end

  def test_move_photo
    date = '2020-08-27'
    target_directory = @sort_photos.target_directory
    example_photo_filename = 'IMG_6036.jpg'

    # TODO Refactor date into variable
    target_photo = "#{@sort_photos.target_directory}/#{date}/#{example_photo_filename}"

    @sort_photos.move_photo @example_photo

    assert_true File.exist?(target_photo)
    assert_false File.exist?(@example_photo)
  end

end
