# frozen_string_literal: true

class Video < ApplicationRecord
  validates :title, presence: true
  validates :shared_by, presence: true
  validates :description, presence: true
  validates :url, presence: true
end
