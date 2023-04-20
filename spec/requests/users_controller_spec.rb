require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET #new' do
    it 'renders the new template' do
      get new_user_path
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          user: {
            email: 'user@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new user and redirects to root_path' do
        post users_path, params: valid_params
        expect(response).to redirect_to(root_path)
        expect(User.last.email).to eq('user@example.com')
        expect(session[:need_register]).to be_falsey
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          user: {
            email: 'user@example.com',
            password: 'password',
            password_confirmation: 'wrong_password'
          }
        }
      end

      it 'does not create a new user and renders the videos/index template' do
        post users_path, params: invalid_params
        expect(response).to redirect_to root_path
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
end
