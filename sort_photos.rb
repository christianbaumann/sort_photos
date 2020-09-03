require 'exifr/jpeg'
require 'fileutils'

class SortPhotos

  attr_accessor :target_directory

  def initialize
    @target_directory = 'sorted'
  end

  def get_date photo
    date_time = EXIFR::JPEG.new(photo).date_time
    date_time.to_s[0, 10]
  end

  def create_directory photo
    date = get_date(photo)
    directories_created = FileUtils.mkdir_p "#{@target_directory}/#{date}"
    directories_created[0]
  end

  def get_filename photo
    photo.split('/')[1]
  end

  def move_photo photo
    date = get_date photo
    sub_directory = create_directory photo
    filename = get_filename photo
    FileUtils.mv(photo, "#{@target_directory}/#{date}/#{filename}")
  end

end
