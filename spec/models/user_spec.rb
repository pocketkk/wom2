require 'spec_helper'

describe User do
  it { should validate_uniqueness_of(:device_token) }
end
