require 'spec_helper'

describe Workorder, 'Validations' do
  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone) }
end

describe Workorder, 'Associations' do
  it { should belong_to(:user) }
end
