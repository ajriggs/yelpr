require 'spec_helper'

describe UsersController do
  it { should use_before_action :require_login }
  it { should use_before_action :require_logout }

  describe 'GET new' do
    it 'sets @user as a new instance of User class' do
      get :new
      expect(assigns :user).to be_a_new User
    end
  end

  describe 'POST create' do
    let(:user_params) { Fabricate.attributes_for :user }
    context 'always' do
      it 'sets @user based on attributes provided in user params' do
        post :create, user: user_params
        expect(assigns(:user).email).to eq user_params[:email]
      end
    end

    context 'with valid input' do
      before { post :create, user: user_params }

      it 'saves @user as a new db record' do
        expect(User.first.username).to eq user_params[:username]
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the root path (home page)' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid input' do
      let(:invalid_params) { { user: {} } }
      before { post :create, user: invalid_params }
      it 'does not save @user as a new db record' do
        expect(User.count).to eq 0
      end

      it 'sets flash[:error]' do
        expect(flash[:error]).to be_present
      end

      it 'renders the register page again' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET show' do
    let(:user) { Fabricate :user }

    before do
      test_login user: user
      get :show, id: user      
    end

    it 'sets @user based on the id of the logged in user' do
      expect(assigns :user).to eq user
    end
  end
end
