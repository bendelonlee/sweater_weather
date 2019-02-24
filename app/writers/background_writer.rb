class BackgroundWriter
  def find_or_fetch(args)
    set_and_save_keywords(args[:keywords])
    return found_background if found_background

    Background.create(
      {
        source: fetch_source
      }
    )
  end

  private

  def set_and_save_keywords(keywords)
    @keywords = keywords.split(',').map(&:strip).map do |kw|
      Keyword.find_or_create_by(word: kw)
    end
  end

  def found_background
    Background.find_by(key_words: @keywords)
  end

  def formatted_keywords
    @key_words.join(', ')
  end

  def found_city
    @_city ||= Background.find_by(name: @key_words)
  end



  def service
    @_service ||= FlickrService.new()
  end

  def coordinates
    @_coordinates ||= service.coordinates
  end

  def country
    service.country
  end

  def state
    service.country
  end
end
