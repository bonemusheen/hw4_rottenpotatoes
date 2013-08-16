class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.same_director(movie)
    Movie.find_all_by_director(movie.director)
  end
end
