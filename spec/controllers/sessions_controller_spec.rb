require 'spec_helper'

describe SessionsController do
  describe 'POST create' do
    let!(:user) { Fabricate :user }

    context 'with valid credentials' do
      before { post :create, email: user.email, password: user.password }

      it "sets the session id to the user's id" do
        expect(session[:user_id]).to eq user.id
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the root path (home page)' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, email: user.email, password: (user.password + '1')
      end

      it 'does not set a session id' do
        expect(session[:user_id]).not_to be_present
      end

      it 'sets flash[:error]' do
        expect(flash[:error]).to be_present
      end

      it 'renders the login page again' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET destroy' do
    let!(:user) { Fabricate :user }

    before do
      session[:user_id] = user.id
      get :destroy
    end

    it 'clears the session id (sets to nil)' do
      expect(session[:user_id]).to be nil
    end

    it 'sets flash[:notice]' do
      expect(flash[:notice]).to be_present
    end

    it 'redirects to the root path (home page)' do
      expect(response).to redirect_to root_path
    end
  end
end
