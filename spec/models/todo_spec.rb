require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
end
