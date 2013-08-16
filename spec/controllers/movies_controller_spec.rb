require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do
    describe 'with director data' do
      before :each do
        @fake_movie = mock(Movie, :title => 'Movie 1', :director => 'director', :id => 1)
        Movie.stub(:find_by_id).and_return(@fake_movie)
      end

      it 'should generate route for movies with same director' do
        { :get => '/similar' }.
        should route_to(:controller => 'movies', :action => 'same_director')
      end

      it 'should call the model method that finds movies with the same director' do
        Movie.should_receive(:find_all_by_director).with('director').and_return(@fake_movie)
        get :same_director, { :id => 1 }
      end

      describe 'after valid search' do
        before :each do
          Movie.stub(:find_all_by_director).with('director').and_return(@fake_movie)
          get :same_director, { :id => 1 }
        end

        it 'should render the same directors template' do
          response.should render_template(:same_director)
        end

        it 'should make results available to same directors template' do
          assigns(:movies).should eq @fake_movie
        end
      end
    end
      
    describe 'without director data' do
      before :each do
        @another_fake_movie = mock(Movie, :title => "Wut", :director => nil, :id => 999)
        @fake_results = []
        Movie.stub(:find_by_id).and_return(@another_fake_movie)
        Movie.stub(:find_all_by_director).with(nil).and_return(@fake_results)
      end

      it 'should redirect to home page' do
        get :same_director, { :id => 999 }
        response.should redirect_to(movies_path)
      end

      it 'should notify that director information is missing for selected movie' do
        get :same_director, { :id => 999 }
        flash[:notice].should match(/has no director info/)
      end
    end
  end

  describe 'create a new movie' do
    it 'should render the new movie template' do
      get :new
      response.should render_template :new
    end
  end
end