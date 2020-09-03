require 'test/unit'
require 'zip'

require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @example_photos_directory = 'example_photos'
    example_photos_zip = 'example_photos.zip'
    example_photo = "IMG_6036.jpg"

    @example_photo_path = "#{@example_photos_directory}/#{example_photo}"

    @sort_photos = SortPhotos.new

    unzip_examples(@example_photos_directory, example_photos_zip)
  end

  def teardown
    FileUtils.rm_rf @sort_photos.target_directory

    Dir.glob("#{@example_photos_directory}/*.jpg").each { |file| File.delete(file)}
  end

  def test_get_date
    assert_equal '2020-08-27', @sort_photos.get_date(@example_photo_path), "Dates don't match"
  end

  def test_create_directory
    date = @sort_photos.get_date(@example_photo_path)
    target_directory = @sort_photos.target_directory

    assert_equal "#{target_directory}/#{date}", @sort_photos.create_directory(@example_photo_path), 'Directory path is not correct'
    assert_true File.directory?("#{target_directory}/#{date}"), "Directory doesn't exist"
  end

  def test_get_filename
    assert_equal 'IMG_6036.jpg', @sort_photos.get_filename(@example_photo_path), "Filenames don't match"
  end

  def test_move_photo
    date = '2020-08-27'
    target_directory = @sort_photos.target_directory
    example_photo_filename = 'IMG_6036.jpg'

    # TODO Refactor date into variable
    target_photo = "#{@sort_photos.target_directory}/#{date}/#{example_photo_filename}"

    @sort_photos.move_photo @example_photo_path

    assert_true File.exist?(target_photo)
    assert_false File.exist?(@example_photo_path)
  end

  private

  def unzip_examples(destination, file)
    file = "#{@example_photos_directory}/#{file}"

    FileUtils.mkdir_p(destination)

    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

end
