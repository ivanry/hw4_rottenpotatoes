class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_by_id id
    movie = Movie.find(id)
    director = movie.director
    Movie.find_by_director(director)
  end
end
