# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_user' do
    let!(:user) { create(:user) }

    context 'with user logged in' do
      before { session[:user_id] = user.id }

      it 'returns the current logged-in user' do
        redirect_to root_path
        expect(controller.current_user).to eq(user)
      end
    end

    context 'with user not logged in' do
      before { session[:user_id] = nil }

      it 'returns nil' do
        redirect_to root_path
        expect(controller.current_user).to be_nil
      end
    end
  end

  describe '#videos_list' do
    let!(:video1) { create(:video) }
    let!(:video2) { create(:video) }

    it 'assigns all videos to @videos_list' do
      redirect_to root_path
      expect(controller.videos_list).to eq([video1, video2])
    end
  end

  describe '#need_register?' do
    context 'with session[:need_register] set to true' do
      before { session[:need_register] = true }

      it 'returns true' do
        redirect_to root_path
        expect(controller.need_register?).to be_truthy
      end
    end

    context 'with session[:need_register] set to false' do
      before { session[:need_register] = false }

      it 'returns false' do
        redirect_to root_path
        expect(controller.need_register?).to be_falsey
      end
    end
  end

  describe 'helper methods' do
    it 'defines helper methods for current_user, videos_list, and need_register?' do
      expect(controller.view_context.methods).to include(:current_user, :videos_list, :need_register?)
    end
  end
end
