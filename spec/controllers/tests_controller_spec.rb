require 'spec_helper'
describe TestsController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'dispached view object' do
      expect(assigns(:view_object).title).to eq 'test index by view object'
    end

    it 'call before render method' do
      expect(assigns(:view_object).called_before_render?).to eq true
    end
  end
end
