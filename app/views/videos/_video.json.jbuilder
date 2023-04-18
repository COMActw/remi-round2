# frozen_string_literal: true

json.extract! video, :id, :title, :shared_by, :description, :embed_code, :created_at, :updated_at
json.url video_url(video, format: :json)
