require 'exifr/jpeg'

class SortPhotos

  def get_date photo
    date_time = EXIFR::JPEG.new(photo).date_time
    date_time.to_s[0, 10]
  end

end
