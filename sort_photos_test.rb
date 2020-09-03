require 'test/unit'
require 'zip'

require_relative 'sort_photos'

class SortPhotosTest < Test::Unit::TestCase
  def setup
    @sort_photos = SortPhotos.new

    @example_photos_directory = 'example_photos'
    @example_photo_filename = 'IMG_6036.jpg'
    @example_photo_date = '2020-08-27'
    example_photos_zip = 'example_photos.zip'
    @example_photo_path = "#{@example_photos_directory}/#{@example_photo_filename}"
    @target_directory = @sort_photos.target_directory

    unzip_examples(@example_photos_directory, example_photos_zip)
  end

  def teardown
    FileUtils.rm_rf @sort_photos.target_directory

    Dir.glob("#{@example_photos_directory}/*.jpg").each { |file| File.delete(file) }
  end

  def test_get_date
    assert_equal @example_photo_date, @sort_photos.get_date(@example_photo_path), "Dates don't match"
  end

  def test_create_directory
    assert_equal "#{@target_directory}/#{@example_photo_date}", @sort_photos.create_directory(@example_photo_path), 'Directory path is not correct'
    assert_true File.directory?("#{@target_directory}/#{@example_photo_date}"), "Directory doesn't exist"
  end

  def test_get_filename
    assert_equal @example_photo_filename, @sort_photos.get_filename(@example_photo_path), "Filenames don't match"
  end

  def test_move_photo
    target_photo = "#{@target_directory}/#{@example_photo_date}/#{@example_photo_filename}"

    @sort_photos.move_photo @example_photo_path

    assert_true File.exist?(target_photo)
    assert_false File.exist?(@example_photo_path)
  end

  def test_sort_photos
    test_photos = []
    test_photos << {'name' => 'IMG_6036.jpg', 'date' => '2020-08-27'}
    test_photos << {'name' => 'IMG_6183.jpg', 'date' => '2020-08-31'}
    test_photos << {'name' => 'IMG_6216.jpg', 'date' => '2020-09-01'}
    test_photos << {'name' => 'IMG_6239.jpg', 'date' => '2020-09-03'}
    test_photos << {'name' => 'IMG_6243.jpg', 'date' => '2020-09-03'}

    @sort_photos.sort_photos @example_photos_directory

    test_photos.each do |photo|
      example_photo_path = "#{@example_photos_directory}/#{photo['name']}"
      example_photo_date = photo['date']
      target_photo = "#{@target_directory}/#{example_photo_date}/#{photo['name']}"

      assert_true File.exist?(target_photo)
      assert_false File.exist?(example_photo_path)
    end
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
