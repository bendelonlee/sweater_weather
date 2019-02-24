class FlickrService
  def initialize(keywords)
    @keywords = keywords
  end

  def image_source
    large_image_info['source']
  end

  private

  def large_image_info
    image_sizes.find{|photo| photo["label"] == 'Large'}
  end

  def image_id
    parsed_search['rsp']['photos']['photo'][0]['id']
  end

  def image_sizes
    parsed_image_sizes['rsp']['sizes']['size']
  end

  def parsed_search
    @_search ||= Hash.from_xml(get_search.body)
  end

  def parsed_image_sizes
    @_sizes ||= Hash.from_xml(get_image_sizes.body)
  end

  def get_search
    connection.get("services/rest") do |f|
      f.params[:method] = 'flickr.photos.search'
    end
  end

  def get_image_sizes
    connection.get("services/rest") do |f|
      f.params[:method] = 'flickr.photos.getSizes'
      f.params[:photo_id] = image_id
    end
  end

  def connection
    Faraday.new(url: 'https://api.flickr.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['FLICKR_API_KEY']
      f.params[:tags] = @keywords
      f.params[:sort] = 'relevance'
    end
  end
end
