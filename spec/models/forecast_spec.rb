require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'relationships' do
    it { should belong_to :city }
  end
end
