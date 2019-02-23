require "rails_helper"

describe Weather do
  describe 'validations' do
  end
  describe 'relationships' do
    it { should belong_to :city }
  end
end
