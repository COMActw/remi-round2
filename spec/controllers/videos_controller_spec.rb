# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new Video' do
      get :new
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        { video: { url: 'https://www.youtube.com/watch?v=vIWY3BE2uvE' } }
      end

      before do
        User.create({
                      email: 'someone@gmail.com',
                      password: '1'
                    })
        session[:user_id] = User.first.id
      end

      it 'creates a new video' do
        expect do
          post :create, params: valid_params
        end.to change(Video, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { video: { url: '' } }
      end

      it 'does not create a new video' do
        expect do
          post :create, params: invalid_params
        end.to_not change(Video, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
