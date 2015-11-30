require 'rails_helper'

describe MoviesController do
    describe 'searching similar movies by director' do
        it 'should call the model method that performs similar directors search' do
            Movie.should_receive(:find_by_director).with('Alan Smithee')
            movie = FactoryGirl.create(:movie)
            get :search_by_director, {:id => movie.id}
        end
        it 'should select the Similar Movies template for rendering if results found' do
            fake_results = [double('Movie'), double('Movie')]
            Movie.stub(:find_by_director).and_return(fake_results)
            movie = FactoryGirl.create(:movie)
            get :search_by_director, {:id => movie.id}
            response.should render_template('search_by_director')
        end
        it 'should make the Similar Movies search result available in that template' do
            fake_results = [double('Movie'), double('Movie')]
            Movie.stub(:find_by_director).and_return(fake_results)
            movie = FactoryGirl.create(:movie)
            get :search_by_director, {:id => movie.id}
            assigns(:movies).should == fake_results
        end
    end
end