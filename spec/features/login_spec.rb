require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Login', type: :system do
  it 'displays User not exist message' do
    visit root_path

    fill_in 'session[email]', with: 'usertest1@example.com'
    fill_in 'session[password]', with: 'password'

    click_on 'Log in'
    expect(page).to have_content('User not exist')
    expect(page).to have_current_path(root_path)
  end

  it 'display login failed' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest1@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('Resgister success')

    fill_in 'session[email]', with: 'usertest1@example.com'
    fill_in 'session[password]', with: '1'

    click_on 'Log in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to have_current_path(root_path)
  end

  it 'display login success' do
    visit root_path

    click_on 'Register'

    fill_in 'user[email]', with: 'usertest2@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Register'
    expect(page).to have_content('Resgister success')

    fill_in 'session[email]', with: 'usertest2@example.com'
    fill_in 'session[password]', with: 'password'

    click_on 'Log in'

    expect(page).to have_content('Login success')
    expect(page).to have_current_path(root_path)
    click_on 'Log out'
  end
end
