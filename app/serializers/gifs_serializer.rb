class GifsSerializer < ActiveModel::Serializer
  attributes :days
  def days
    object.each do |day|
      {
        summary: day.summary,
        time:    day.time,
        gif_url: day.gif_url
      }
    end
  end
end
