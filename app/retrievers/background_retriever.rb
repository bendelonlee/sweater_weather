class BackgroundRetriever
  KEYWORDS = ', city, sky, panoramic'
  def find_or_fetch(args)
    set_and_save_keywords(args[:keywords])
    return found_background if found_background
    Background::Image.create(
      {
        source: fetch_source,
        keywords: @keywords
      }
    )
  end

  private

  def fetch_source
    service.image_source
  end

  def keyword_list
    @keywords.pluck(:word).join(", ") + KEYWORDS
  end

  def set_and_save_keywords(keywords)
    @keywords = keywords.split(',').map(&:strip).map do |kw|
      Background::Keyword.find_or_create_by(word: kw)
    end
  end

  def found_background
    Background::Image.joins(:keywords).find_by(background_keywords: {id: @keywords})
  end

  def formatted_keywords
    @key_words.join(', ')
  end

  def service
    @_service ||= FlickrService.new(keyword_list)
  end

  def coordinates
    @_coordinates ||= service.coordinates
  end
end
