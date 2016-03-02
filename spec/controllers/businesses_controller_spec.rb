require 'spec_helper'

describe BusinessesController do
  describe 'GET index' do
    it 'sets @businesses to a max of 10 elements' do
      11.times { Fabricate :business }
      get :index
      expect(assigns(:businesses).count).to eq 10
    end
  end

  describe 'GET show' do
    it 'sets @business based on the id provided via params' do
      apple = Fabricate :business, name: "Apple"
      get :show, id: apple.id
      expect(assigns :business).to eq apple
    end
  end

  describe 'GET new' do
    it 'sets @business as a new instance of Business class' do
      get :new
      expect(assigns :business).to be_a_new Business
    end
  end

  describe 'POST create' do
    let(:business_params) { Fabricate.attributes_for :business }
    context 'always' do
      it 'sets @business with the attributes provided in user params' do
        post :create, business: business_params
        expect(assigns(:business).name).to eq business_params[:name]
      end
    end

    context 'with valid input' do
      before { post :create, business: business_params }

      it 'saves @business as a new db record' do
        expect(Business.first.name).to eq business_params[:name]
      end

      it 'redirects to the root path (home page)' do
        expect(response).to redirect_to root_path
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid submission' do
      let(:invalid_params) { { business: {} } }
      before { post :create, business: invalid_params }

      it 'does not save the @business instance as a new db record' do
        expect(Business.count).to eq 0
      end

      it 'renders the add business page again' do
        expect(response).to render_template :new
      end

      it 'sets flash[:error]' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET search' do
    let(:business) { Fabricate :business }

    it 'sets @search_results based on the results of the query provided' do
      get :search, query: business.name
      expect(assigns :search_results).to include business
    end
  end
end
