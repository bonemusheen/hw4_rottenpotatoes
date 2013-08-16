require 'spec_helper'

describe Movie do
  describe 'finding movies by a director' do
    it 'should call Movie with director' do
      Movie.should_receive(:same_director).with('Movie Title')
      Movie.same_director('Movie Title')
    end

    it 'should return movies by director' do
      test_movie = Movie.create(:title => 'Movie Title', :director => 'director')
      Movie.same_director(test_movie).should include(test_movie)
    end
  end
end