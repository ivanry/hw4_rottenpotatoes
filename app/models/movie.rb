class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_by_id id
    movie = Movie.find(id)
    director = movie.director
    logger.debug "director=#{director}"
    if (director.nil? or director.empty?)
      raise "'#{movie.title}' has no director info"
    end
    Movie.find_all_by_director(director)
  end
end
