require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new User' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        { user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
      end

      it 'redirects to root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { user: { email: '', password: 'password', password_confirmation: 'password' } }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_params
        end.to_not change(User, :count)
      end

      it 'sets session[:need_register] to true' do
        post :create, params: invalid_params
        expect(session[:need_register]).to be_truthy
      end

      it 'renders the videos/index template with unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
