# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it do
      should validate_numericality_of(:amount).
        is_greater_than(0)
    end
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end
end
