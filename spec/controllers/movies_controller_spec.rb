require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    before :each do
      @fake_results = [mock('Movie1'), mock('Movie2')]
      @empty_results = []
      @fake_id = '123'
      @fake_director = 'Director1'
      #@fake_params = {:id => '123'}

      @movie1 = mock('Movie')
      @movie1.stub(:id).and_return 123
      @movie1.stub(:director).and_return 'Director1'

      @movie2 = mock('Movie')
      @movie2.stub(:id).and_return 2
      @movie2.stub(:director).and_return ''
      @movie2.stub(:title).and_return 'Title1'
    end

    it 'tests route' do
      assert_routing 'movies/find_similar/123', {:controller => 'movies', :action => 'find_similar', :id => '123'}
    end

    it 'should receive id and pass it to Movie finder' do
      Movie.should_receive(:find_similar_by_id).with(@fake_id).and_return @fake_results

      get :find_similar, {:id => @fake_id}
    end


    it 'should receive id and pass it to Movie finder' do
      Movie.should_receive(:find).with(@fake_id).and_return @movie1
      Movie.should_receive(:find_all_by_director).with(@fake_director).and_return @fake_results

      get :find_similar, {:id => @fake_id}
    end
    it 'should render results page' do
      Movie.stub(:find).and_return @movie1

      get :find_similar, {:id => @fake_id}
      response.should render_template 'find_similar'
    end
    it 'should assign results to template variable' do
      Movie.stub(:find).and_return @movie1
      Movie.stub(:find_all_by_director).and_return @fake_results

      get :find_similar, {:id => @fake_id}
      assigns(:movies).should == @fake_results
    end
    it 'should redirect to home page if search for undefined director' do
      Movie.stub(:find).
          and_return(@movie2)
      Movie.stub(:find_all_by_director).
          and_return(@empty_results)

      get :find_similar, {:id => @fake_id}
      response.should redirect_to(movies_path)
    end
  end
end