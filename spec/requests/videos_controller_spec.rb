require 'rails_helper'

RSpec.describe 'VideosController', type: :request do
  describe 'GET #index' do
    it 'renders the index template and assigns @videos' do
      videos = create_list(:video, 3)
      get videos_path
      expect(response).to render_template(:index)
      expect(assigns(:videos)).to eq(videos)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get new_video_path
      expect(response).to render_template(:new)
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        params = { email: 'someone@gmail.com', password: '1' }
        User.create(params)
        post login_path, params: { session: params }
      end

      let(:valid_params) do
        {
          video: {
            url: 'https://www.youtube.com/watch?v=vIWY3BE2uvE'
          }
        }
      end

      it 'creates a new video and redirects to root_path' do
        post videos_path, params: valid_params
        expect(response).to redirect_to(root_path)
        expect(Video.last.url).to eq('https://www.youtube.com/watch?v=vIWY3BE2uvE')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          video: {
            url: ''
          }
        }
      end

      it 'does not create a new video and renders the new template' do
        post videos_path, params: invalid_params
        expect(response).to render_template(:new)
        expect(assigns(:video)).to be_a_new(Video)
      end
    end
  end
end