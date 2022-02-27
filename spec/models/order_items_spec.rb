# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    xit do
      should validate_numericality_of(:quantity).
        is_greater_than(0)
    end
  end
  describe 'associations' do
    it { should belong_to(:order) }
  end
end