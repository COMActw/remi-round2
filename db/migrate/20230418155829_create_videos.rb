# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :shared_by
      t.string :description
      t.string :embed_code

      t.timestamps
    end
  end
end
