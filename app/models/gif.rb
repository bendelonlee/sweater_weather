class Gif < ApplicationRecord

  def self.save_from_array(array, icon)
    array.each do |hash|
      Gif.find_or_create_by!(icon: icon, gif_url: hash[:embed_url])
    end
  end

end
