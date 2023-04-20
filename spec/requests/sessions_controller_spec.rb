require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  let!(:user) { create(:user, email: 'someone@example.com', password: 'password') }

  describe 'GET #new' do
    it 'renders the new template' do
      get login_path
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user and redirects to root_path' do
        post login_path, params: { session: { email: 'someone@example.com', password: 'password' } }
        expect(response).to redirect_to(root_path)
        expect(session[:user_id]).to eq(user.id)
        expect(session[:need_register]).to be_falsey
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user and sets need_register to true' do
        post login_path, params: { session: { email: 'someone@example.com', password: 'wrong_password' } }
        expect(response).to redirect_to(root_path)
        expect(session[:user_id]).to be_nil
        expect(session[:need_register]).to be_falsey
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      post login_path, params: { session: { email: 'someone@example.com', password: 'password' } }
      session[:user_id] = user.id
    end

    it 'logs out the user and redirects to root_path' do
      delete logout_path(user)
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to be_nil
    end
  end
end
