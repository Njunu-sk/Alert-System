require 'rails_helper'

RSpec.describe Alert, type: :model do
  it { should belong_to(:user) } 
end
