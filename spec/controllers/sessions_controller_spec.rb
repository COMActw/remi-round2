# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets session[:need_register] to false if not already set' do
      get :new
      expect(session[:need_register]).to be_falsey
    end

    it 'does not change session[:need_register] if already set' do
      session[:need_register] = true
      get :new
      expect(session[:need_register]).to be_falsey
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid params' do
      let(:valid_params) do
        { session: { email: 'test@example.com', password: 'password' } }
      end

      it 'sets session[:user_id] to user id' do
        post :create, params: valid_params
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets session[:need_register] to false' do
        post :create, params: valid_params
        expect(session[:need_register]).to be_falsey
      end

      it 'redirects to root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { session: { email: 'test@example.com', password: 'wrong_password' } }
      end

      it 'sets session[:need_register] to true' do
        post :create, params: invalid_params
        expect(session[:need_register]).to be_falsey
      end

      it 'redirects to root path' do
        post :create, params: invalid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { session[:user_id] = 1 }

    it 'sets session[:user_id] to nil' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'before_action #find_user' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    it 'finds the correct user by email' do
      post :create, params: { session: { email: 'test@example.com', password: 'password' } }
      expect(assigns(:user)).to eq(user)
    end
  end
end
