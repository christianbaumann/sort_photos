require 'exifr/jpeg'

class SortPhotos

  def get_year photo
    date_time = EXIFR::JPEG.new(photo).date_time
    date_time.to_s[0,4]
  end

end
