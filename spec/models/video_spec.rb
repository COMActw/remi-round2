# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:shared_by) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url) }
  end
end
