require 'spec_helper'

describe ReviewsController do
  it { should use_before_action :require_login }

  describe 'POST create' do
    let(:user) { Fabricate :user }
    let(:business) { Fabricate :business }
    let(:invalid_params) { { review: {} } }
    let(:review_params) do
      Fabricate.attributes_for(:review)
    end

    context 'always' do
      before do
        test_login user: user
        post :create, business_id: business.id, review: invalid_params
      end

      it 'associates @review to the current user' do
        expect(assigns(:review).user).to eq user
      end

      it 'associates @review to the current business' do
        expect(assigns(:review).business).to eq business
      end
    end

    context 'with valid input' do
      before do
        test_login user: user
        post :create, business_id: business.id, review: review_params
      end

      it 'saves @review as a new db record' do
        expect(Review.first.body).to eq review_params[:body]
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the business page' do
        expect(response).to redirect_to business_path(business)
      end
    end
  end
end
