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
    FileUtils.mkdir_p "#{@target_directory}/#{date}"
  end

end
