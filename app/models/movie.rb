class Movie < ActiveRecord::Base
  RATINGS = %w[G PG PG-13 R NC-17]  #  %w[] shortcut for array of strings
  validates :title, :presence => true
  validates :release_date, :presence => true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, :inclusion => {:in => RATINGS}, :unless => :grandfathered?
  def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
        self.release_date < Date.parse('1 Jan 1930')
  end

  @@grandfathered_date = Date.parse('1 Jan 1930')
  def grandfathered? ; self.release_date >= @@grandfathered_date ; end

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
