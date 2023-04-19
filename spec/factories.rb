# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'abc@xyz.com' }
    password { 'password' }
  end

  factory :video do
    title { 'This is title' }
    shared_by { 'abc@xyz.com' }
    description { 'This is description' }
    url { 'https://www.youtube.com/watch?v=vIWY3BE2uvE' }
    embed_code do
      '<iframe src=\"//www.youtube.com/embed/vIWY3BE2uvE\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe>'
    end
  end
end
