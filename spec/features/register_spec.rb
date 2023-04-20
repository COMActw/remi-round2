require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Register', type: :system do
  it 'display confirmation password not match' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest1@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: '1'

    click_on 'Register'
    expect(page).to have_content('Confirmation password not match')
    expect(page).to have_current_path(root_path)
  end

  it 'display user already exist' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest3@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('Resgister success')
    click_on 'Register'

    fill_in 'user[email]', with: 'usertest3@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('User already exist')
    expect(page).to have_current_path(root_path)
  end

  it 'display user already exist' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest4@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('Resgister success')
  end
end
