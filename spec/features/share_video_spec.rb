require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Share Video', type: :system do
  it 'displays error message when video has errors' do
    visit new_video_path

    fill_in 'video[url]', with: 'invalid_url'
    click_button 'Create Video'

    expect(page).to have_content('Invalid URL')
  end

  it 'creates a video with a valid URL' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('Resgister success')

    fill_in 'session[email]', with: 'usertest@example.com'
    fill_in 'session[password]', with: 'password'

    click_on 'Log in'
    expect(page).to have_content('Login success')

    visit new_video_path

    fill_in 'video[url]', with: 'https://www.youtube.com/watch?v=vIWY3BE2uvE'
    click_on 'Create Video'

    expect(page).to have_content('Video was successfully created')
    expect(page).to have_current_path(root_path)
    click_on 'Log out'
  end
end
