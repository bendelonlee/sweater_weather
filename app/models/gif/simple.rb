class Gif::Simple
  attr_reader :summary, :time, :gif_url

  def self.from_gifs(gifs)
    gifs.map do |gif|
      new(gif)
    end
  end

  def initialize(gif)
    @summary = gif.summary
    @time = gif.time
    @gif_url = gif.gif_url
  end
end
